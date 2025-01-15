part of 'account_settings_bloc.dart';

class AccountSettingsState extends Equatable {
  const AccountSettingsState({
    this.status = Status.initial,
    this.userStatus = Status.initial,
    this.message = '',
  });
  final Status status;
  final Status userStatus;
  final String message;

  AccountSettingsState copyWith({
    Status? status,
    Status? userStatus,
    String? message,
  }) {
    return AccountSettingsState(
      status: status ?? this.status,
      userStatus: userStatus ?? this.status,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [status, userStatus, message];
}
