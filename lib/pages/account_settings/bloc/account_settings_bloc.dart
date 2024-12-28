import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  AccountSettingsBloc() : super(const AccountSettingsState()) {
    on<AccountEventPressed>(_onAccountEventPressed);
  }

  void _onAccountEventPressed(AccountEventPressed event, Emitter<AccountSettingsState> emit) async {
    emit(state.copyWith(status: Status.initial));

    try {
      // TODO:
      // final uid = FirebaseAuth.instance.currentUser!.uid;
      // final account = event.account;
      // final method = event.method.toLowerCase();

      // _firebaseRepository.addUserRequest(
      //   UserRequest(
      //     dataRequest: '${method}_account|$uid|$account',
      //     extraData: '',
      //     ownerId: uid,
      //     timeStamp: DateTime.now()
      //   )
      // );

      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
