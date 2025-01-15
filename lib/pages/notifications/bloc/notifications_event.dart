part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

final class NotificationsFetched extends NotificationsEvent {}

final class NotificationsStreamed extends NotificationsEvent {}

final class NotificationsUpdated extends NotificationsEvent {
  const NotificationsUpdated({required this.notifications});
  final List<Notification> notifications;
  
  @override
  List<Object> get props => [notifications];
}

final class NotificationsUpdateIsRead extends NotificationsEvent {
  const NotificationsUpdateIsRead(this.notification);
  final Notification notification;

  @override
  List<Object> get props => [notification];
}