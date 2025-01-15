import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginConfirmPasswordChanged>(_onLoginConfirmPasswordChanged);
    on<LoginPasswordObscured>(_onLoginPasswordObscured);
    on<LoginConfirmPasswordObscured>(_onLoginConfirmPasswordObscured);
    on<LoggedInWithCredentials>(_onLoggedInWithCredentials);
    on<ConfirmSubmitted>(_onConfirmSubmitted);
    on<SignInResults>(_onSignInResults);
    on<PinCodeChanged>(_onPinCodeChanged);
    on<LoginMfaChanged>(_onLoginMfaChanged);
    //
    on<ConfirmSignInWithSmsMfaCode>(_onConfirmSignInWithSmsMfaCode);
    on<ConfirmSignInWithNewPassword>(_onConfirmSignInWithNewPassword);
    on<ConfirmSignInWithCustomChallenge>(_onConfirmSignInWithCustomChallenge);
    on<ResetPassword>(_onResetPassword);
    on<HandlePasswordResetCodeDelivery>(_onHandlePasswordResetCodeDelivery);
    on<ResetPasswordWithCodeConfirmed>(_onResetPasswordWithCodeConfirmed);
    on<ResetPasswordDone>(_onResetPasswordDone);
    on<ConfirmSignUp>(_onConfirmSignUp);
    on<SignUpConfirmed>(_onSignUpConfirmed);
    on<ConfirmSignInWithMfaSelection>(_onConfirmSignInWithMfaSelection);
    on<ContinueSignInWithTotpSetup>(_onContinueSignInWithTotpSetup);
    on<ConfirmSignInWithTotpMfaCode>(_onConfirmSignInWithTotpMfaCode);
    on<SignInConfirmed>(_onSignInConfirmed);
    on<AuthSignInStepDone>(_onAuthSignInStepDone);
  }
  Timer? _timer;

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onLoginConfirmPasswordChanged(LoginConfirmPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(confirmedPassword: ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword)));
  }

  void _onPinCodeChanged(PinCodeChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(pinCode: Name.dirty(event.pinCode)));
  }

  void _onLoginPasswordObscured(LoginPasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _onLoginConfirmPasswordObscured(LoginConfirmPasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isConfirmObscure: !state.isConfirmObscure));
  }

  void _onLoginMfaChanged(LoginMfaChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(mfa: event.mfa));
  }

  FutureOr<void> _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final result = await Amplify.Auth.signIn(username: state.email.value, password: state.password.value); 
        add(SignInResults(result));
      } on AuthException catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  Future<void> _onSignInResults(SignInResults event, Emitter<LoginState> emit) async {
    switch(event.result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        add(ConfirmSignInWithSmsMfaCode(event.result));
        break;
      case AuthSignInStep.confirmSignUp:
        add(ConfirmSignUp());
        break;
      case AuthSignInStep.confirmSignInWithTotpMfaCode:
        add(ConfirmSignInWithTotpMfaCode());
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        add(ConfirmSignInWithNewPassword());
        break;
      case AuthSignInStep.resetPassword:
        add(ResetPassword());
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        add(ConfirmSignInWithCustomChallenge(event.result));
        break;
      case AuthSignInStep.continueSignInWithMfaSelection:
        add(ConfirmSignInWithMfaSelection(event.result));
        break;
      case AuthSignInStep.continueSignInWithTotpSetup:
        add(ContinueSignInWithTotpSetup(event.result));
        break;
      case AuthSignInStep.done:
        add(AuthSignInStepDone());
        break;
      case AuthSignInStep.continueSignInWithMfaSetupSelection:
        // TODO: Handle this case.
        throw UnimplementedError();
      case AuthSignInStep.continueSignInWithEmailMfaSetup:
        // TODO: Handle this case.
        throw UnimplementedError();
      case AuthSignInStep.confirmSignInWithOtpCode:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void _onConfirmSubmitted(ConfirmSubmitted event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final code = event.code;
    if (state.signInSteps.isConfirmSignInWithSmsMfaCode || state.signInSteps.isConfirmSignInWithTotpMfaCode || state.signInSteps.isContinueSignInWithTotpSetup) {
      if (code != null) {
        add(SignInConfirmed(code));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
      }
    }
    if (state.signInSteps.isConfirmSignUp) {
      if(code != null) {
        add(SignUpConfirmed(code));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
      }
    }
    if (state.signInSteps.isConfirmSignInWithNewPassword) {
      final password = state.password;
      if (password.isValid && state.confirmedPassword.isValid) {
        add(SignInConfirmed(password.value));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
        emit(state.copyWith(status: FormzSubmissionStatus.initial));
      }
    }
    if(state.signInSteps.isResetPassword) {
      add(ResetPasswordWithCodeConfirmed());
    }
    if(state.signInSteps.isContinueSignInWithMfaSelection) {
      // default mfa [sms]
      add(SignInConfirmed(state.mfa.confirmationValue));
    }
  }
  
  void _onConfirmSignInWithSmsMfaCode(ConfirmSignInWithSmsMfaCode event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      signInSteps: SignInSteps.confirmSignInWithSmsMfaCode,
      message: 'A confirmation code has been sent to ${details.destination}. ''Please check your ${details.deliveryMedium.name} for the code.',
    ));
  }

  Future<void> _onConfirmSignUp(ConfirmSignUp event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(username: state.email.value); // resend the code
      emit(state.copyWith(
        status: FormzSubmissionStatus.canceled,
        signInSteps: SignInSteps.confirmSignUp,
        message: 'A confirmation code has been sent to ${result.codeDeliveryDetails.destination}. '
        'Please check your ${result.codeDeliveryDetails.deliveryMedium.name} for the code.'
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onConfirmSignInWithTotpMfaCode(ConfirmSignInWithTotpMfaCode event, Emitter<LoginState> emit) {
    emit(state.copyWith(signInSteps: SignInSteps.confirmSignInWithTotpMfaCode));
  }

  // CONFIRM SIGNUP
  Future<void> _onSignUpConfirmed(SignUpConfirmed event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(username: state.email.value, confirmationCode: event.code);
      if(result.isSignUpComplete) {
        emit(state.copyWith(status: FormzSubmissionStatus.canceled, signInSteps: SignInSteps.initial, message: TextString.signUpConfirmed));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  // CONFIRM SIGNIN
  Future<void> _onSignInConfirmed(SignInConfirmed event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.confirmSignIn(confirmationValue: event.code);
      add(SignInResults(result));
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onConfirmSignInWithNewPassword(ConfirmSignInWithNewPassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.canceled, signInSteps: SignInSteps.confirmSignInWithNewPassword, message: TextString.newPassword));
  }

  void _onConfirmSignInWithCustomChallenge(ConfirmSignInWithCustomChallenge event, Emitter<LoginState> emit) {
    final parameters = event.result.nextStep.additionalInfo;
    final prompt = parameters['prompt'] ?? '';
    emit(state.copyWith(signInSteps: SignInSteps.confirmSignInWithCustomChallenge, message: prompt));
  }

  // ======================== >>> RESET PASSWORD =========================== >>>
  void _onResetPassword(ResetPassword event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.resetPassword(username: state.email.value);
      switch(result.nextStep.updateStep) {
        case AuthResetPasswordStep.confirmResetPasswordWithCode:
          add(HandlePasswordResetCodeDelivery(result));
          break;
        case AuthResetPasswordStep.done:
          add(ResetPasswordDone());
          break;
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onHandlePasswordResetCodeDelivery(HandlePasswordResetCodeDelivery event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      signInSteps: SignInSteps.resetPassword,
      message: 'A confirmation code has been sent to ${details.destination}. ''Please check your ${details.deliveryMedium.name} for the code.'
    ));
  }

  Future<void> _onResetPasswordWithCodeConfirmed(ResetPasswordWithCodeConfirmed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final auth = state.pinCode;
      final username = state.email;
      final password = state.password;
      if (auth.isValid && username.isValid && password.isValid) {
        final result = await Amplify.Auth.confirmResetPassword(confirmationCode: auth.value, username: username.value, newPassword: password.value);
        if (result.isPasswordReset) {
          add(ResetPasswordDone());
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.resetPasswordFail));
        }
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onResetPasswordDone(ResetPasswordDone event, Emitter<LoginState> emit) {
    emit(state.copyWith(signInSteps: SignInSteps.initial, status: FormzSubmissionStatus.canceled, message: TextString.resetPasswordDone));
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
  // <<< ===================== RESET PASSWORD END ========================== <<<

  void _onConfirmSignInWithMfaSelection(ConfirmSignInWithMfaSelection event, Emitter<LoginState> emit) async {
    final allowedMfaTypes = event.result.nextStep.allowedMfaTypes!;
    emit(state.copyWith(signInSteps: SignInSteps.continueSignInWithMfaSelection, mfaTypes: allowedMfaTypes));
  }

  void _onContinueSignInWithTotpSetup(ContinueSignInWithTotpSetup event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.totpSetupDetails!;
    emit(state.copyWith(totpDetails: details));
    // final setupUri = details.getSetupUri(appName: 'FCBPay');
  }

  void _onAuthSignInStepDone(AuthSignInStepDone event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
