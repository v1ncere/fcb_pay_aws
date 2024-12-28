part of 'login_bloc.dart';

class LoginState extends Equatable with FormzMixin {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.pinCode = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isObscure = true,
    this.isConfirmObscure = true,
    this.signInSteps = SignInSteps.initial,
    this.mfaTypes = const <MfaType>{},
    this.mfa = MfaType.sms,
    this.totpDetails,
    this.message = '',
  });
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Name pinCode;
  final bool isObscure;
  final bool isConfirmObscure;
  final SignInSteps signInSteps;
  final FormzSubmissionStatus status;
  final Set<MfaType> mfaTypes;
  final MfaType mfa;
  final TotpSetupDetails? totpDetails;
  final String message;
  
  LoginState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Name? pinCode,
    FormzSubmissionStatus? status,
    bool? isObscure,
    bool? isConfirmObscure,
    SignInSteps? signInSteps,
    Set<MfaType>? mfaTypes,
    MfaType? mfa,
    TotpSetupDetails? totpDetails,
    String? message
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      pinCode: pinCode ?? this.pinCode,
      status: status ?? this.status,
      isObscure: isObscure ?? this.isObscure,
      isConfirmObscure: isConfirmObscure ?? this.isConfirmObscure,
      signInSteps: signInSteps ?? this.signInSteps,
      mfaTypes: mfaTypes ?? this.mfaTypes,
      mfa: mfa ?? this.mfa,
      totpDetails: totpDetails ?? this.totpDetails,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    confirmedPassword,
    pinCode,
    status,
    isObscure,
    isConfirmObscure,
    signInSteps,
    message,
    mfaTypes,
    mfa,
    totpDetails,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [email, password];
}

enum LoginOption { email, phone, google }

extension LoginOptionX on LoginOption {
  bool get isEmail => this == LoginOption.email;
  bool get isPhone => this == LoginOption.phone;
  bool get isGoogle => this == LoginOption.google;
}

enum SignInSteps {
  initial,
  confirmSignInWithSmsMfaCode,
  confirmSignInWithTotpMfaCode,
  confirmSignInWithNewPassword,
  confirmSignInWithCustomChallenge,
  continueSignInWithMfaSelection,
  continueSignInWithTotpSetup,
  resetPassword,
  confirmSignUp,
  done,
}

extension SignInStepsX on SignInSteps {
  bool get isInitial => this == SignInSteps.initial;
  bool get isConfirmSignInWithSmsMfaCode => this == SignInSteps.confirmSignInWithSmsMfaCode;
  bool get isConfirmSignInWithTotpMfaCode => this == SignInSteps.confirmSignInWithTotpMfaCode;
  bool get isConfirmSignInWithNewPassword => this == SignInSteps.confirmSignInWithNewPassword;
  bool get isConfirmSignInWithCustomChallenge => this == SignInSteps.confirmSignInWithCustomChallenge;
  bool get isContinueSignInWithMfaSelection => this == SignInSteps.continueSignInWithMfaSelection;
  bool get isContinueSignInWithTotpSetup => this == SignInSteps.continueSignInWithTotpSetup;
  bool get isResetPassword => this == SignInSteps.resetPassword;
  bool get isConfirmSignUp => this == SignInSteps.confirmSignUp;
  bool get isDone => this == SignInSteps.done;
}