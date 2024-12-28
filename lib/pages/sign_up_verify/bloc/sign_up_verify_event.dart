part of 'sign_up_verify_bloc.dart';

sealed class SignUpVerifyEvent extends Equatable {
  const SignUpVerifyEvent();

  @override
  List<Object> get props => [];
}

final class AccountTypeDropdownChanged extends SignUpVerifyEvent {
  const AccountTypeDropdownChanged(this.accountType);
  final AccountType accountType;

  @override
  List<Object> get props => [accountType];
}

final class AccountNumberChanged extends SignUpVerifyEvent {
  const AccountNumberChanged(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}

final class FirstNameChanged extends SignUpVerifyEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class MiddleNameChanged extends SignUpVerifyEvent {
  const MiddleNameChanged(this.middleName);
  final String middleName;

  @override
  List<Object> get props => [middleName];
}

final class LastNameChanged extends SignUpVerifyEvent {
  const LastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class BirthDateChanged extends SignUpVerifyEvent {
  const BirthDateChanged(this.date);
  final DateTime date;
  
  @override
  List<Object> get props => [date];
}

final class BirthStringChanged extends SignUpVerifyEvent {
  const BirthStringChanged(this.date);
  final String date;
  
  @override
  List<Object> get props => [date];
}

final class VerifySubmitted extends SignUpVerifyEvent {}

final class AccountVerified extends SignUpVerifyEvent {}

final class AccountVerifyReplyStreamed extends SignUpVerifyEvent {
  const AccountVerifyReplyStreamed(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class AccountVerifyReplyUpdated extends SignUpVerifyEvent {
  const AccountVerifyReplyUpdated(this.signupVerifyReply);
  final SignupVerifyReply signupVerifyReply;

  @override
  List<Object> get props => [signupVerifyReply];
}

final class SignupVerifyFailed extends SignUpVerifyEvent {
  const SignupVerifyFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}