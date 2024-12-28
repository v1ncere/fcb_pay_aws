import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'auth_checker_event.dart';
part 'auth_checker_state.dart';

class AuthCheckerBloc extends Bloc<AuthCheckerEvent, AuthCheckerState> {
  AuthCheckerBloc({
    required HivePinRepository hivePinRepository
  }) : _hivePinRepository = hivePinRepository,
  super(const AuthCheckerState()) {
    on<AuthCheckerPinChecked>(_onAuthCheckerPinChecked);
  }
  final HivePinRepository _hivePinRepository;

  // check if pin exists
  Future<void> _onAuthCheckerPinChecked(AuthCheckerPinChecked event, Emitter<AuthCheckerState> emit) async {
    emit(state.copyWith(status: AuthCheckerStatus.loading));
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final isExist = await _hivePinRepository.isPinAuthExist(user.userId);
      emit(state.copyWith(
        status: AuthCheckerStatus.success, 
        userName: '${user.signInDetails.toJson()['username']}',
        isPinExist: isExist
      ));
    } on AuthException catch (_) {
      emit(state.copyWith(status: AuthCheckerStatus.failure));
    } catch (_) {
      emit(state.copyWith(status: AuthCheckerStatus.failure));
    }
  }
}
