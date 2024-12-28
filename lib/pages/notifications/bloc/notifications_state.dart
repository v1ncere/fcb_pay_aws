part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const <Notification>[],
    this.uid = '',
    this.status = Status.initial,
    this.userStatus = Status.initial,
    this.updateStatus = Status.initial,
    this.message = ''
  });
  final List<Notification> notifications;
  final String uid;
  final Status status;
  final Status userStatus;
  final Status updateStatus;
  final String message;

  NotificationsState copyWith({
    List<Notification>? notifications,
    String? uid,
    Status? status,
    Status? userStatus,
    Status? updateStatus,
    String? message,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      userStatus: userStatus ?? this.userStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [notifications, uid, status, userStatus, updateStatus, message];
}
