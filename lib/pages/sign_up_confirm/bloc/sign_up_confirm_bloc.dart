import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_aws/repository/repository.dart';

part 'sign_up_confirm_event.dart';
part 'sign_up_confirm_state.dart';

class SignUpConfirmBloc extends Bloc<SignUpConfirmEvent, SignUpConfirmState> {
  SignUpConfirmBloc({
    required AmplifyAuth amplifyAuth,
  }) : super(const SignUpConfirmState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PinCodeSubmitted>(_onPinCodeSubmitted);
    on<HandleSignUpResult>(_onHandleSignUpResult);
    on<SignUpStepConfirmed>(_onSignUpStepConfirmed);
    on<SignUpStepDone>(_onSignUpStepDone);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<SignUpConfirmState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPinCodeSubmitted(PinCodeSubmitted event, Emitter<SignUpConfirmState> emit) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await Amplify.Auth.confirmSignUp(
        username: state.username.trim(),
        confirmationCode: event.code.trim(),
      );
      add(HandleSignUpResult(result));
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Error confirming user: ${e.message}'));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Error confirming user: ${e.toString()}'));
    }
  }

  Future<void> _onHandleSignUpResult(HandleSignUpResult event, Emitter<SignUpConfirmState> emit) async {
    final steps = event.result.nextStep.signUpStep;
    switch(steps) {
      case AuthSignUpStep.confirmSignUp:
        add(SignUpStepConfirmed(event.result));
        break;
      case AuthSignUpStep.done:
        add(SignUpStepDone());
        break;
    }
  }

  void _onSignUpStepConfirmed(SignUpStepConfirmed event, Emitter<SignUpConfirmState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      message: 'A confirmation code has been sent to ${details.destination}. '
      'Please check your ${details.deliveryMedium.name} for the code.'
    ));
  }

  void _onSignUpStepDone(SignUpStepDone event, Emitter<SignUpConfirmState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.success, message: 'Sign up is complete'));
  }
}
