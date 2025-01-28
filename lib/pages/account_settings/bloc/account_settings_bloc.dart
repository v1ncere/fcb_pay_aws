import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  AccountSettingsBloc() : super(const AccountSettingsState()) {
    on<AccountEventPressed>(_onAccountEventPressed);
  }

  void _onAccountEventPressed(AccountEventPressed event, Emitter<AccountSettingsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final current = await Amplify.Auth.getCurrentUser();
      final title = "${event.method.toLowerCase()}_account";
      final data = '$title|${event.account}|${current.userId}';
      
      // request to alter account
      final request = ModelMutations.create(Request(
        data: data,
        details: title,
        verifier: hashSha1(encryption("$data$title${current.userId}")),  
        owner: current.userId,
      ));
      final response = await Amplify.API.mutate(request: request).response;
      if(response.hasErrors) {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
      emit(state.copyWith(status: Status.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
