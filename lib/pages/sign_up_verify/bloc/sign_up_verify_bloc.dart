import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../models/ModelProvider.dart';
import '../../../repository/repository.dart';
import '../../../utils/utils.dart';

part 'sign_up_verify_event.dart';
part 'sign_up_verify_state.dart';

final verifyReply = SignupVerifyReply(id: '', data: '');

class SignUpVerifyBloc extends Bloc<SignUpVerifyEvent, SignUpVerifyState> {
  SignUpVerifyBloc({
    required AmplifyData amplifyData,
  }) : _amplifyData = amplifyData, 
  super(SignUpVerifyState(
    birthdateController: TextEditingController(),
    signupVerifyReply: verifyReply
  )) {
    on <AccountTypeDropdownChanged>(_onAccountTypeDropdownChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<BirthStringChanged>(_onBirthStringChanged);
    on<VerifySubmitted>(_onVerifySubmitted);
    on<AccountVerified>(_onAccountVerified);
    on<AccountVerifyReplyStreamed>(_onAccountVerifyReplyStreamed);
    on<AccountVerifyReplyUpdated>(_onAccountVerifyReplyUpdated);
    on<SignupVerifyFailed>(_onSignupVerifyFailed);
  }
  final AmplifyData _amplifyData;
  StreamSubscription<GraphQLResponse<SignupVerifyReply>>? _streamSubscription;

  // DROPDOWN ===========================================================================================
  void _onAccountTypeDropdownChanged(AccountTypeDropdownChanged event, Emitter<SignUpVerifyState> emit) {
    emit(state.copyWith(accountType: event.accountType));
  }

  // TEXT FORM FIELDS =========================================================================
  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<SignUpVerifyState> emit) {
    final account = AccountNumber.dirty(event.account);
    emit(state.copyWith(accountNumber: account));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpVerifyState> emit) {
    final firstName = Name.dirty(event.firstName);
    emit(state.copyWith(firstName: firstName));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpVerifyState> emit) {
    final lastName = Name.dirty(event.lastName);
    emit(state.copyWith(lastName: lastName));
  }

  void _onBirthDateChanged(BirthDateChanged event, Emitter<SignUpVerifyState> emit) {
    final dateString = DateFormat('dd/MM/yyyy').format(event.date);
    final controller = TextEditingController(text: dateString);
    emit(state.copyWith(birthdateController: controller));
  }

  void _onBirthStringChanged(BirthStringChanged event, Emitter<SignUpVerifyState> emit) {
    try {
      final date = DateTime.parse(event.date);
      final dateString = DateFormat('dd/MM/yyyy').format(date);
      final controller = TextEditingController(text: dateString);
      emit(state.copyWith(birthdateController: controller));
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  // VERIFY FORM SUBMITTED ========================================================
  void _onVerifySubmitted(VerifySubmitted event, Emitter<SignUpVerifyState> emit) {
    if (isFormValid()) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      add(AccountVerified());
    } else {
      emitError(emit: emit, message: TextString.formError);
    }
  }

  Future<void> _onAccountVerified(AccountVerified event, Emitter<SignUpVerifyState> emit) async {
    try {
      if (!await _isAccountAlreadyUsed()) {
        final result = await _amplifyData.createModelPublic(SignupVerify(data: _dataInterpolation()));
        if (result != null) {
          add(AccountVerifyReplyStreamed(result.id));
        } else {
          emitError(emit: emit, message: TextString.error);
        }
      } else {
        emitError(emit: emit, message: TextString.accountAlreadyLinked);
      }
    } on ApiException catch (e) {
      emitError(emit: emit, message: e.message);
    } catch (_) {
      emitError(emit: emit, message: TextString.error);
    }
  }

  void _onAccountVerifyReplyStreamed(AccountVerifyReplyStreamed event, Emitter<SignUpVerifyState> emit) async {
    final operation = _amplifyData.subscribePublic(
      modelType: SignupVerifyReply.classType,
      type: SubscriptionType.onCreate
    );
    _streamSubscription?.cancel();
    _streamSubscription = operation.listen(
      (response) {
        final reply = response.data;
        if (reply != null) {
          if (reply.id == event.id) {
            add(AccountVerifyReplyUpdated(reply));
          }
        }
      },
      onError: (Object e) => add(const SignupVerifyFailed(TextString.error))
    );

    // TODO: DELETE this after
    Future.delayed(const Duration(seconds: 3), () async {
      await _amplifyData.createModelPublic(SignupVerifyReply(id: event.id, data: 'exist'));
    });
  }

  void _onAccountVerifyReplyUpdated(AccountVerifyReplyUpdated event, Emitter<SignUpVerifyState> emit) {
    if (event.signupVerifyReply != verifyReply) {
      if (isAccountExists(event.signupVerifyReply)) {
        emit(state.copyWith(status: FormzSubmissionStatus.success, signupVerifyReply: event.signupVerifyReply));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.accountNotExist));
      }
    }
  }

  void _onSignupVerifyFailed(SignupVerifyFailed event, Emitter<SignUpVerifyState> emit) {
    emitError(message: event.message, emit: emit);
  }

  // UTILITY METHODS ===========================================================
  // ===========================================================================

  bool isFormValid() {
    final type = state.accountType;
    final birth = state.birthdateController.text;
    //
    if(type.isUnknown || birth.isEmpty) {
      return false;
    }
    //
    if(type.isSavings) {
      return state.isValid && isBirthdateValid();
    }
    return isAccountNumberValid() && isBirthdateValid();
  }

  bool isAccountNumberValid() {
    final accountNumber = state.accountNumber.value;
    final isMatch = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$').hasMatch(accountNumber);
    return accountNumber.isNotEmpty && isMatch;
  }
  
  bool isBirthdateValid() {
    final birthDate = state.birthdateController.text;
    final isMatch = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$').hasMatch(birthDate);
    return birthDate.isNotEmpty && isMatch;
  }

  // if account already in used by user
  Future<bool> _isAccountAlreadyUsed() async {
    try {
      final account = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
      final result = await _amplifyData.queryItemsPublic(
        modelType: PublicAccount.classType,
        modelIdentifier: PublicAccountModelIdentifier(accountNumber: account)
      );
      return result != null ? result.isExisted : false;
    } on ApiException catch (_) {
      throw('Something went wrong! Try again later.');
    }
  }

  String _dataInterpolation() {
    final type = state.accountType;
    final savings = type.isSavings;
    final acct = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    final fName = savings ? '|${state.firstName.value.trim()}' : '';
    final lName = savings ? ',${state.lastName.value.trim()}' : '';
    final birth = state.birthdateController.text.trim();

    return '${type.name}|$acct$fName$lName|$birth';
  }

  void emitError({
    required Emitter<SignUpVerifyState> emit, 
    required String message,
  }) {
    emit(state.copyWith(status: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  bool isAccountExists(SignupVerifyReply reply) {
    return reply.data == 'exist'; // this must be encrypted
  }

  //
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    state.birthdateController.dispose();
    return super.close();
  }
}
