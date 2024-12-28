import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc({
    required HiveRepository hiveRepository,
  }) : _hiveRepository = hiveRepository,
  super(const ReceiptState(status: Status.loading)) {
    on<ReceiptDisplayStreamed>(_onReceiptDisplayStreamed);
    on<ReceiptDisplayUpdated>(_onReceiptDisplayUpdated);
  }
  final HiveRepository _hiveRepository;
  StreamSubscription<GraphQLResponse<Receipt>>? _subscription;

  void _onReceiptDisplayStreamed(ReceiptDisplayStreamed event, Emitter<ReceiptState> emit) async {
    final id = await _hiveRepository.getId();
    final subscriptionRequest = ModelSubscriptions.onCreate(Receipt.classType, where: Receipt.ID.eq(id));
    final operation = Amplify.API.subscribe(subscriptionRequest, onEstablished: () => safePrint('Subscription Established'));
    _subscription = operation.listen(
      (event) => add(ReceiptDisplayUpdated(event.data)),
      onError: (Object e) => emit(state.copyWith(status: Status.failure, message: e.toString()))
    );
  }

  void _onReceiptDisplayUpdated(ReceiptDisplayUpdated event, Emitter<ReceiptState> emit) async {
    final receipt = event.receipt;
    if (receipt != null) {
      final Map<String, dynamic> parsedData = jsonDecode(receipt.data!);
      emit(state.copyWith(status: Status.success, receiptMap: parsedData));
    } else {
      emit(state.copyWith(status: Status.loading));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}