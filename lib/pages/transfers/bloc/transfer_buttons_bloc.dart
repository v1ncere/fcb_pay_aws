import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'transfer_buttons_event.dart';
part 'transfer_buttons_state.dart';

class TransferButtonsBloc extends Bloc<TransferButtonsEvent, TransferButtonsState> {
  TransferButtonsBloc() : super(const TransferButtonsState(status: Status.loading)) {
    on<TransferButtonsFetched>(_onTransferButtonsFetched);
    on<TransferButtonsRefreshed>(_onTransferButtonsRefreshed);
  }

  Future<void> _onTransferButtonsFetched(TransferButtonsFetched event, Emitter<TransferButtonsState> emit)  async {
    final internetStatus = await checkNetworkStatus();
    if (internetStatus) {
      try {
        final request = ModelQueries.list(Button.classType, where: Button.TYPE.eq('transfer'));
        final response = await Amplify.API.query(request: request).response;
        final items = response.data?.items;

        if(items != null && items.isNotEmpty) {
          final buttons = items.whereType<Button>().toList();
          buttons.sort((a, b) => a.position!.compareTo(b.position!));
          emit(state.copyWith(status: Status.success, buttons: buttons));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } on ApiException catch (e) {
        emit(state.copyWith(status: Status.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: Status.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: Status.failure, message: 'disconnected...'));
    }
  }

  void _onTransferButtonsRefreshed(TransferButtonsRefreshed event, Emitter<TransferButtonsState> emit) {
    emit(state.copyWith(status: Status.loading));
    add(TransferButtonsFetched());
  }
}
