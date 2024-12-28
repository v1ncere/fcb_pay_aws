 import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_viewer_event.dart';
part 'notifications_viewer_state.dart';

class NotificationsViewerBloc extends Bloc<NotificationsViewerEvent, NotificationsViewerState> {
  NotificationsViewerBloc() :  super(NotificationsViewerLoading()) {
    on<NotificationViewerLoaded>(_onNotificationViewerLoaded);
    on<NotificationDelete>(_onNotificationDelete);
  }

  void _onNotificationViewerLoaded(NotificationViewerLoaded event, Emitter<NotificationsViewerState> emit) async {
    try {
      final request = ModelQueries.get(Notification.classType, NotificationModelIdentifier(id: event.id));
      final response = await Amplify.API.query(request: request).response;
      final data = response.data;

      if(data != null) {
        emit(NotificationsViewerSuccess(notification: data));
      } else {
        emit(NotificationsViewerError(message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(NotificationsViewerError(message: e.message));
    } catch (e) {
      emit(NotificationsViewerError(message: e.toString()));
    }
  }

  void _onNotificationDelete(NotificationDelete event, Emitter<NotificationsViewerState> emit) async {
    try {
      final request = ModelMutations.deleteById(Notification.classType, NotificationModelIdentifier(id: event.id));
      await Amplify.API.mutate(request: request).response;
    } catch (e) {
      emit(NotificationsViewerError(message: e.toString()));
    }
  }

}
