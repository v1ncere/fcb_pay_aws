import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'payment_buttons_event.dart';
part 'payment_buttons_state.dart';

class PaymentButtonsBloc extends Bloc<PaymentButtonsEvent, PaymentButtonsState> {
  PaymentButtonsBloc() : super(PaymentButtonsLoading()) {
    on<PaymentButtonsFetched>(_onPaymentButtonsFetched);
    on<PaymentButtonsRefreshed>(_onPaymentButtonsRefreshed);
    on<PaymentButtonsFailed>(_onPaymentButtonsFailed);
  }

  Future<void> _onPaymentButtonsFetched(PaymentButtonsFetched event, Emitter<PaymentButtonsState> emit) async {
    final internetStatus = await checkNetworkStatus();
    if (internetStatus) {
      try {
        final request = ModelQueries.list(Button.classType, where: Button.TYPE.eq('payment'));
        final response = await Amplify.API.query(request: request).response;
        final items = response.data?.items;

        if (items != null && items.isNotEmpty) {
          final buttons = items.whereType<Button>().toList();
          buttons.sort((a, b) => a.position!.compareTo(b.position!));
          emit(PaymentButtonsSuccess(buttons));
        } else {
          emit(const PaymentButtonsError(message: TextString.empty));
        }
      } on ApiException catch (e) {
        emit(PaymentButtonsError(message: e.message));
      } catch (e) {
        emit(PaymentButtonsError(message: e.toString()));
      }
    } else {
      emit(const PaymentButtonsError(message: 'disconnected...'));
    }
  }

  void _onPaymentButtonsRefreshed(PaymentButtonsRefreshed event, Emitter<PaymentButtonsState> emit) {
    emit(PaymentButtonsLoading());
    add(PaymentButtonsRefreshed());
  }

  void _onPaymentButtonsFailed(PaymentButtonsFailed event, Emitter<PaymentButtonsState> emit) {
    emit(PaymentButtonsError(message: event.message));
  }
}
