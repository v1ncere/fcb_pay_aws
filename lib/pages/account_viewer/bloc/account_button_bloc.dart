import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/AccountButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/Button.dart';
import '../../../utils/utils.dart';

part 'account_button_event.dart';
part 'account_button_state.dart';

class AccountButtonBloc extends Bloc<AccountButtonEvent, AccountButtonState> {
  AccountButtonBloc() : super(const AccountButtonState(status: Status.loading)) {
    on<ButtonsFetched>(_onButtonsFetched);
  }

  void _onButtonsFetched(ButtonsFetched event, Emitter<AccountButtonState> emit) async {
    try {
      final request = ModelQueries.get<AccountButton>(AccountButton.classType, AccountButtonModelIdentifier(type: event.type)); // acount type i.e.(wallet, cc, sa)
      final response = await Amplify.API.query(request: request).response; // query from graphql
      final accountButton = response.data;
      // 
      if(accountButton != null) {
        final firstRequest = ModelQueries.list<Button>(Button.classType, where: Button.ACCOUNTBUTTON.eq(accountButton.type));
        final firstResult = await Amplify.API.query(request: firstRequest).response;
        final firstPageData = firstResult.data?.items;
        //
        if (firstPageData != null) {
          final data = firstPageData.whereType<Button>().toList();
          emit(state.copyWith(status: Status.success, buttonList: data));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: TextString.empty));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.empty));
    }
  }
}