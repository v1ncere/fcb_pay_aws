part of 'sign_up_confirm_bloc.dart';

sealed class SignUpConfirmEvent extends Equatable {
  const SignUpConfirmEvent();

  @override
  List<Object> get props => [];
}

final class UsernameChanged extends SignUpConfirmEvent {
  const UsernameChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

final class PinCodeSubmitted extends SignUpConfirmEvent {
  const PinCodeSubmitted(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

final class HandleSignUpResult extends SignUpConfirmEvent {
  const HandleSignUpResult(this.result);
  final SignUpResult result;

  @override
  List<Object> get props => [result];
}

final class SignUpStepConfirmed extends SignUpConfirmEvent {
  const SignUpStepConfirmed(this.result);
  final SignUpResult result;

  @override
  List<Object> get props => [result];
}

final class SignUpStepDone extends SignUpConfirmEvent {}
