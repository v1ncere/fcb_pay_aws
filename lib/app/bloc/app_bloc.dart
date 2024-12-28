import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    // login checked
    on<LoginChecked>((event, emit) async {
      try {
        final session = await Amplify.Auth.fetchAuthSession();
        emit(
          state.copyWith(
            status: session.isSignedIn
            ? LogStatus.authenticated
            : LogStatus.unauthenticated
          )
        );
      } on AuthException catch (_) {
        emit(state.copyWith(status: LogStatus.unknown));
      } catch (_) {
        emit(state.copyWith(status: LogStatus.unknown));
      }
    });
    // logout
    on<LoggedOut>((event, emit) async {
      final result = await Amplify.Auth.signOut();
      if (result is CognitoCompleteSignOut) {
        emit(state.copyWith(status: LogStatus.unauthenticated));
      } else if (result is CognitoFailedSignOut) {
        emit(state.copyWith(status: LogStatus.unknown));
      }
    });
  }
}

