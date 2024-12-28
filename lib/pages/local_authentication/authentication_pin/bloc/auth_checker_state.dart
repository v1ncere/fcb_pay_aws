part of 'auth_checker_bloc.dart';

class AuthCheckerState extends Equatable {
  const AuthCheckerState({
    this.isPinExist = false,
    this.userName = '',
    this.status = AuthCheckerStatus.initial,
    this.message = ''
  });
  final bool isPinExist;
  final String userName;
  final AuthCheckerStatus status;
  final String message;

  AuthCheckerState copyWith({
    bool? isPinExist,
    String? userName,
    AuthCheckerStatus? status,
    String? message,
  }) {
    return AuthCheckerState(
      isPinExist: isPinExist ?? this.isPinExist,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [ isPinExist, userName, status, message ];
}

enum AuthCheckerStatus { initial, loading, success, failure }
extension AuthCheckerStatusX on AuthCheckerStatus {
  bool get isInitial => this == AuthCheckerStatus.initial;
  bool get isLoading => this == AuthCheckerStatus.loading;
  bool get isSuccess => this == AuthCheckerStatus.success;
  bool get isFailure => this == AuthCheckerStatus.failure;
}

