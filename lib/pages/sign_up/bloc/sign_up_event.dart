part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends SignUpEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class FirstNameChanged extends SignUpEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class LastNameChanged extends SignUpEvent {
  const LastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class MobileNumberChanged extends SignUpEvent {
  const MobileNumberChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}

final class UsernameChanged extends SignUpEvent {
  const UsernameChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

final class PasswordChanged extends SignUpEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmPasswordChanged extends SignUpEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
    required this.password
  });
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}

final class UserImageChanged extends SignUpEvent {
  const UserImageChanged(this.image);
  final XFile image;

  @override
  List<Object> get props => [image];
}

final class AccountNumberChanged extends SignUpEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class EmailTextErased extends SignUpEvent {}

final class FirstNameTextErased extends SignUpEvent {}

final class LastNameTextErased extends SignUpEvent {}

final class MobileTextErased extends SignUpEvent {}

final class UsernameTextErased extends SignUpEvent {}

final class PasswordTextErased extends SignUpEvent {}

final class ConfirmPasswordTextErased extends SignUpEvent {}

final class PasswordObscured extends SignUpEvent {}

final class ConfirmPasswordObscured extends SignUpEvent {}

final class LostDataRetrieved extends SignUpEvent {}

final class FormSubmissionFailed extends SignUpEvent {
  const FormSubmissionFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

final class UploadImageProgressed extends SignUpEvent {
  const UploadImageProgressed(this.progress);
  final double progress;

  @override
  List<Object> get props => [progress];
}

final class FormSubmitted extends SignUpEvent {}

final class ImageUploadProgressed extends SignUpEvent {
  const ImageUploadProgressed(this.progress);
  final double progress;

  @override
  List<Object> get props => [progress];
}

final class HandleSignUp extends SignUpEvent {
  const HandleSignUp(this.url);
  final String url;

  @override
  List<Object> get props => [url];
}

final class HandleSignupResult extends SignUpEvent {
  const HandleSignupResult(this.result);
  final SignUpResult result;

  @override
  List<Object> get props => [result];
}

final class AuthSignupStepConfirmed extends SignUpEvent {
  const AuthSignupStepConfirmed(this.result);
  final SignUpResult result;

  @override
  List<Object> get props => [result];
}

final class AuthSignupStepDone extends SignUpEvent {
  const AuthSignupStepDone(this.result);
  final SignUpResult result;

  @override
  List<Object> get props => [result];
}

final class HydrateStateChanged extends SignUpEvent {
  const HydrateStateChanged({required this.isHydrated});
  final bool isHydrated;

  @override
  List<Object> get props => [isHydrated];
}
