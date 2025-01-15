part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const <Notification>[],
    this.status = Status.initial,
    this.userStatus = Status.initial,
    this.updateStatus = Status.initial,
    this.message = ''
  });
  final List<Notification> notifications;
  
  final Status status;
  final Status userStatus;
  final Status updateStatus;
  final String message;

  NotificationsState copyWith({
    List<Notification>? notifications,
    
    Status? status,
    Status? userStatus,
    Status? updateStatus,
    String? message,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
      userStatus: userStatus ?? this.userStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [notifications, status, userStatus, updateStatus, message];
}
