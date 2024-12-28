part of 'sign_up_bloc.dart';

class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    //
    this.email = const Email.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.mobile = const MobileNumber.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.userImage,
    this.accountNumber = '',
    //
    this.imageStatus = Status.initial,
    this.status = Status.initial,
    //
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    //
    this.progress = 0.0,
    this.message = '',
    this.isHydrated = false,
  });
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  //
  final Email email;
  final Name firstName;
  final Name lastName;
  final MobileNumber mobile;
  final Username username;
  final Password password;
  final ConfirmedPassword confirmPassword;
  final XFile? userImage;
  final String accountNumber;
  //
  final Status imageStatus;
  final Status status;
  //
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  //
  final double progress;
  final String message;
  final bool isHydrated;
  
  SignUpState copyWith({
    // controllers
    TextEditingController? emailController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? mobileController,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    //
    Email? email,
    Name? firstName,
    Name? lastName,
    MobileNumber? mobile,
    Username? username,
    Password? password,
    ConfirmedPassword? confirmPassword,
    XFile? userImage,
    String? accountNumber,
    //
    Status? imageStatus,
    Status? status,
    //
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    //
    double? progress,
    String? message,
    bool? isHydrated,
  }) {
    return SignUpState(
      emailController: emailController ?? this.emailController,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      mobileController: mobileController ?? this.mobileController,
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      //
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      userImage: userImage ?? this.userImage,
      accountNumber: accountNumber ?? this.accountNumber,
      //
      imageStatus: imageStatus ?? this.imageStatus,
      status: status ?? this.status,
      //
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      //
      progress: progress ?? this.progress,
      message: message ?? this.message,
      isHydrated: isHydrated ?? this.isHydrated
    );
  }
  
  @override
  List<Object?> get props => [
    emailController,
    firstNameController,
    lastNameController,
    mobileController,
    usernameController,
    passwordController,
    confirmPasswordController,
    //
    email,
    firstName,
    lastName,
    mobile,
    username,
    password,
    confirmPassword,
    userImage,
    accountNumber,
    //
    imageStatus,
    status,
    //
    obscurePassword,
    obscureConfirmPassword,
    //
    progress,
    message,
    isHydrated,
    //
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [
    email,
    firstName,
    lastName,
    mobile,
    username,
    password,
    confirmPassword
  ];
}