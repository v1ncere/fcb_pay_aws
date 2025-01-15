import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc() : super(const TransactionHistoryState()) {
    on<TransactionHistoryLoaded>(_onTransactionHistoryLoaded);
    on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
  }

  void _onTransactionHistoryLoaded(TransactionHistoryLoaded event,  Emitter<TransactionHistoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    const limit = 50;
    
    final request = ModelQueries.list(Transaction.classType, where: Transaction.ACCOUNT.eq(event.accountID), limit: limit);
    final response = await Amplify.API.query(request: request).response;
    final firstPageData = response.data;
    final items = response.data?.items;

    if (items != null) {
      List<Transaction> transactionList = <Transaction>[];
      //
      if(firstPageData?.hasNextResult ?? false) {
        final secondRequest = firstPageData!.requestForNextResult;
        final secondResult = await Amplify.API.query(request: secondRequest!).response;
        final secondItem = secondResult.data?.items ?? <Transaction?>[];
        transactionList = secondItem.whereType<Transaction>().toList();
      } else {
        transactionList = items.whereType<Transaction>().toList();
      }

      final query = event.searchQuery.trim().toLowerCase(); // case insensitive
      final filter = event.filter.trim().toLowerCase(); // case insensitive

      if (event.filter.isNotEmpty) {
        if (filter == 'newest') {
          transactionList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        } else if (filter == 'oldest') {
          transactionList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        } else {
          transactionList = transactionList.where((trans) {
            return trans.accountType!.trim().toLowerCase().contains(filter);
          }).toList();
        }
      }
      
      if (event.searchQuery.isNotEmpty) {
        transactionList = transactionList.where((e) => e.details!.toLowerCase().contains(query)).toList();
      }
      
      if (transactionList.isNotEmpty) {
        state.copyWith(status: Status.success, transactionList: transactionList);
      } else {
        state.copyWith(status: Status.failure, message: TextString.empty);
      }
    } else {
      state.copyWith(status: Status.failure, message: TextString.empty);
    }
  }

  void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<TransactionHistoryState> emit) {
    final search = Search.dirty(event.searchQuery);
    emit(state.copyWith(searchQuery: search));
  }
}