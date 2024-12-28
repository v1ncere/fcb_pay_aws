part of 'sign_up_verify_bloc.dart';

class SignUpVerifyState extends Equatable with FormzMixin {
  const SignUpVerifyState({
    this.accountType = AccountType.unknown,
    required this.signupVerifyReply,
    required this.birthdateController,
    this.accountNumber = const AccountNumber.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final AccountType accountType;
  final SignupVerifyReply signupVerifyReply;
  final TextEditingController birthdateController;
  final AccountNumber accountNumber;
  final Name firstName;
  final Name lastName;
  final FormzSubmissionStatus status;
  final String message;

  SignUpVerifyState copyWith({
    AccountType? accountType,
    SignupVerifyReply? signupVerifyReply,
    TextEditingController? birthdateController,
    AccountNumber? accountNumber,
    Name? firstName,
    Name? lastName,
    FormzSubmissionStatus? status,
    String? message,
  }) {
    return SignUpVerifyState(
      accountType: accountType ?? this.accountType,
      signupVerifyReply: signupVerifyReply ?? this.signupVerifyReply,
      birthdateController: birthdateController ?? this.birthdateController,
      accountNumber: accountNumber ?? this.accountNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    accountType,
    signupVerifyReply,
    birthdateController,
    accountNumber,
    firstName,
    lastName,
    status,
    message,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [
    accountNumber,
    firstName,
    lastName
  ];
}
