part of 'sign_up_confirm_bloc.dart';

class SignUpConfirmState extends Equatable {
  const SignUpConfirmState({
    this.username = '',
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
  });
  final String username;
  final FormzSubmissionStatus status;
  final String message;

  SignUpConfirmState copyWith({
    String? username,
    FormzSubmissionStatus? status,
    String? message,
  }) {
    return SignUpConfirmState(
      username: username ?? this.username,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [username, status, message];
}