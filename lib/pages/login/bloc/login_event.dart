part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginConfirmPasswordChanged extends LoginEvent {
  const LoginConfirmPasswordChanged({required this.password, required this.confirmPassword});
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginPasswordObscured extends LoginEvent {}

final class LoginConfirmPasswordObscured extends LoginEvent {}

final class PinCodeChanged extends LoginEvent {
  const PinCodeChanged(this.pinCode);
  final String pinCode;

  @override
  List<Object> get props => [pinCode];
}

final class LoggedInWithCredentials extends LoginEvent {}

final class ConfirmSubmitted extends LoginEvent {
  const ConfirmSubmitted({this.code});
  final String? code;

  @override
  List<Object> get props => [code!];
}

final class SignInResults extends LoginEvent {
  const SignInResults(this.result);
  final SignInResult result;

  @override
  List<Object> get props => [result];
}

final class ConfirmSignInWithSmsMfaCode extends LoginEvent {
  const ConfirmSignInWithSmsMfaCode(this.result);
  final SignInResult result;

  @override
  List<Object> get props => [result];
}

final class ConfirmSignInWithNewPassword extends LoginEvent {}

final class ConfirmSignInWithCustomChallenge extends LoginEvent {
  const ConfirmSignInWithCustomChallenge(this.result);
  final SignInResult result;

  @override
  List<Object> get props => [result];
}

final class ResetPassword extends LoginEvent {}

final class HandlePasswordResetCodeDelivery extends LoginEvent {
  const HandlePasswordResetCodeDelivery(this.result);
  final ResetPasswordResult result;

  @override
  List<Object> get props => [result];
}

final class ResetPasswordWithCodeConfirmed extends LoginEvent {}

final class ResetPasswordDone extends LoginEvent {}

final class ConfirmSignUp extends LoginEvent {}

final class SignUpConfirmed extends LoginEvent {
  const SignUpConfirmed(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

final class ConfirmSignInWithMfaSelection extends LoginEvent {
  const ConfirmSignInWithMfaSelection(this.result);
  final SignInResult  result;

  @override
  List<Object> get props => [result];
}

final class LoginMfaChanged extends LoginEvent {
  const LoginMfaChanged(this.mfa);
  final MfaType mfa;

  @override
  List<Object> get props => [mfa];
}

final class ContinueSignInWithTotpSetup extends LoginEvent {
  const ContinueSignInWithTotpSetup(this.result);
  final SignInResult result;

  @override
  List<Object> get props => [result];
}

final class ConfirmSignInWithTotpMfaCode extends LoginEvent {}

final class SignInConfirmed extends LoginEvent {
  const SignInConfirmed(this.code);
  final String code;

  @override
  List<Object> get props => [code]; 
}

final class AuthSignInStepDone extends LoginEvent {}