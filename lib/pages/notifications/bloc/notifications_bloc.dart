import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState(status: Status.loading)) {
    on<NotificationsFetched>(_onNotificationsFetched);
    on<NotificationsStreamed>(_onNotificationsStreamed);
    on<NotificationsUpdated>(_onNotificationsUpdated);
    on<NotificationsUpdateIsRead>(_onNotificationsUpdateIsRead);
  }
  StreamSubscription<GraphQLResponse<Notification>>? subscription;

  Future<void> _onNotificationsFetched(NotificationsFetched event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final request = ModelQueries.list(Notification.classType, where: Notification.OWNER.eq(user.userId));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if (items != null) {
        final notifications = items.whereType<Notification>().toList();
        add(NotificationsUpdated(notifications: notifications));
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  void _onNotificationsStreamed(NotificationsStreamed event, Emitter<NotificationsState> emit) async {
    final user = await Amplify.Auth.getCurrentUser();
    final subscriptionRequest = ModelSubscriptions.onCreate(Notification.classType, where: Notification.OWNER.eq(user.userId));
    final operation = Amplify.API.subscribe(subscriptionRequest, onEstablished: () => safePrint('Subscription Established'));
    subscription = operation.listen(
      (event) {
        final notification = state.notifications;
        notification.add(event.data!);
        add(NotificationsUpdated(notifications: notification));
      }, onError: (error) {
        emit(state.copyWith(status: Status.failure, message: error.toString()));
      }
    );
  }
  
  void _onNotificationsUpdated(NotificationsUpdated event, Emitter<NotificationsState> emit) async {
    if (event.notifications.isEmpty) {
      emit(state.copyWith(status: Status.failure, message: 'Empty'));
    } else {
      final unread = event.notifications.where((e) => !e.isRead!).toList();
      final read = event.notifications.where((e) => e.isRead!).toList();
      emit(state.copyWith(status: Status.success, notifications: [...unread, ...read]));
    }
  }

  void _onNotificationsUpdateIsRead(NotificationsUpdateIsRead event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      final notification = event.notification;
      final updateNotifications = notification.copyWith(isRead: true);
      final request = ModelMutations.update(updateNotifications, where: Notification.ID.eq(notification.id));
      final response = await Amplify.API.mutate(request: request).response;
      emit(state.copyWith(updateStatus: Status.success, message: response.toString()));
    } on ApiException catch (e) {
      emit(state.copyWith(updateStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.failure, message: e.toString()));
    }
  }
}
