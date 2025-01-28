import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';

part 'account_add_event.dart';
part 'account_add_state.dart';

class AccountAddBloc extends Bloc<AccountAddEvent, AccountAddState> {
  AccountAddBloc() : super(AccountAddState(birthdateController: TextEditingController())) {
    on<AccountTypeDropdownChanged>(_onAccountTypeDropdownChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthdateChanged>(_onBirthdateChanged);
    on<AccountFormSubmitted>(_onAccountFormSubmitted);
    on<AccountVerified>(_onAccountVerified);
    on<AccountVerifyReplyStreamed>(_onAccountVerifyReplyStreamed);
    on<AccountVerifyReplyUpdated>(_onAccountVerifyReplyUpdated);
    on<AccountVerifyReplyFailed>(_onAccountVerifyReplyFailed);
  }

  StreamSubscription<GraphQLResponse<SignupVerifyReply>>? _streamSubscription;

  void _onAccountTypeDropdownChanged(AccountTypeDropdownChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(accountType: event.accountType));
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(accountNumber: AccountNumber.dirty(event.accountNumber)));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));  
   }  
  
  void _onBirthdateChanged(BirthdateChanged event, Emitter<AccountAddState> emit) {
    final dateString = DateFormat('dd/MM/yyyy').format(event.date); // format into dd/MM/yyyy
    final controller = TextEditingController(text: dateString);
    emit(state.copyWith(birthdateController: controller));
  }

  void _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AccountAddState> emit) {
    if (isFormValid()) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      add(AccountVerified());
    } else {
      emitError(emit, TextString.formError);
    }
  }

  Future<void> _onAccountVerified(AccountVerified event, Emitter<AccountAddState> emit) async {
    try {
      if(!await isAccountAlreadyUsed()) {
        final request = ModelMutations.create(SignupVerify(data: dataInterpolation()));
        final response = await Amplify.API.mutate(request: request).response;
        final result = response.data;
        if (response.hasErrors) {
          emitError(emit, response.errors.first.message);
        } else {
          if (result != null) {
            add(AccountVerifyReplyStreamed(result.id));
          } else {
            emitError(emit, TextString.error);
          }
        }
      }
    } on ApiException catch (e) {
      emitError(emit, e.message);
    } catch (e) {
      emitError(emit, e.toString());
    }
  }

  void _onAccountVerifyReplyStreamed(AccountVerifyReplyStreamed event, Emitter<AccountAddState> emit) {
    final subscriptionRequest = ModelSubscriptions.onCreate(SignupVerifyReply.classType, where: SignupVerifyReply.ID.eq(event.id));
    final operation = Amplify.API.subscribe(subscriptionRequest, onEstablished: () => safePrint('Subscription Established'));

    _streamSubscription?.cancel();
    _streamSubscription = operation.listen(
      (event) {
        final data = event.data;
        if (data != null) {
          add(AccountVerifyReplyUpdated(data));
        }
      },
      onError: (error) => add(const AccountVerifyReplyFailed(TextString.error))
    );
  }

  Future<void> _onAccountVerifyReplyUpdated(AccountVerifyReplyUpdated event, Emitter<AccountAddState> emit) async {
    if (isAccountExists(event.verifyReply)) {
      //
      try {
        final user = await Amplify.Auth.getCurrentUser();
        final title = 'add_account';
        final data = '$title|${state.accountNumber.value}|${state.firstName.value}';
        final request = ModelMutations.create(Request(
          data: data,
          details: title,
          verifier: hashSha1(encryption("$data$title${user.userId}")),
          owner: user.userId,
        ));
        final response = await Amplify.API.mutate(request: request).response;
        if (response.hasErrors) {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.accountAddFailure));
        } else {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.success, message: TextString.accountAddSuccess));
        }
      } on AuthException catch (e) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
      } on ApiException catch (e) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.accountNotExist));
    }
  }

  void _onAccountVerifyReplyFailed(AccountVerifyReplyFailed event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: event.message));
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }
  // UTILITY METHODS ===========================================================
  // ===========================================================================

  bool isFormValid() {
    final type = state.accountType; // AccountType enum
    final birth = state.birthdateController.text;
    //
    if (type.isUnknown || birth.isEmpty) {
      return false;
    }
    //
    if (type.isSavings) {
      return state.isValid && isBirthdateValid();
    }
    //
    return isAccountNumberValid() && isBirthdateValid();
  }

  bool isAccountNumberValid() {
    final accountNumber = state.accountNumber.value;
    final isMatch = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$').hasMatch(accountNumber);
    //
    return accountNumber.isNotEmpty && isMatch;
  }
  
  bool isBirthdateValid() {
    final birthDate = state.birthdateController.text;
    final isMatch = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$').hasMatch(birthDate);
    //
    return birthDate.isNotEmpty && isMatch;
  }

  Future<bool> isAccountAlreadyUsed() async {
    final account = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    final request = ModelQueries.get(PublicAccount.classType, PublicAccountModelIdentifier(accountNumber: account));
    final response = await Amplify.API.query(request: request).response;
    final data = response.data;
    if (data == null) {
      return false;
    }
    return data.isExisted;
  }

  String dataInterpolation() {
    final type = state.accountType;
    final savings = type.isSavings;
    final acct = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    final fName = savings ? '|${state.firstName.value.trim()}' : '';
    final lName = savings ? ',${state.lastName.value.trim()}' : '';
    final birth = state.birthdateController.text.trim();
    //
    return '${type.name}|$acct$fName$lName|$birth';
  }

  void emitError(Emitter<AccountAddState> emit, String message) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }

  bool isAccountExists(SignupVerifyReply verify) {
    return verify.data == 'exist'; // this must be encrypted
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    return super.close();
  }
}
