import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../models/Transaction.dart';
import '../../../utils/utils.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc() : super(const TransactionHistoryState()) {
    on<TransactionHistoryLoaded>(_onTransactionHistoryLoaded);
    on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
    on<NextTransactionFetched>(_onNextTransactionFetched);
  }

  void _onTransactionHistoryLoaded(TransactionHistoryLoaded event,  Emitter<TransactionHistoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    const limit = 50;

    final request = ModelQueries.list(Transaction.classType, where: Transaction.ACCOUNT.eq(event.accountID), limit: limit);
    final response = await Amplify.API.query(request: request).response;
    final firstPageData = response.data;
    final trans = response.data?.items;
   
    List<Transaction> transaction = <Transaction>[];

    if (trans != null) {
      
      if(firstPageData?.hasNextResult ?? false) {
        final secondRequest = firstPageData!.requestForNextResult;
        final secondResult = await Amplify.API.query(request: secondRequest!).response;
        final result = secondResult.data?.items ?? <Transaction?>[];
        transaction = result.whereType<Transaction>().toList();
      } else {
        transaction = trans.whereType<Transaction>().toList();
      }

      final query = event.searchQuery.trim().toLowerCase(); // case insensitive
      final filter = event.filter.trim().toLowerCase(); // case insensitive

      if (event.filter.isNotEmpty) {
        if (filter == 'newest') {
          transaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        } else if (filter == 'oldest') {
          transaction.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        } else {
          transaction = transaction.where((trans) {
            return trans.accountType!.trim().toLowerCase().contains(filter);
          }).toList();
        }
      }
      
      if (event.searchQuery.isNotEmpty) {
        transaction = transaction.where((trans) {
          return trans.details!.toLowerCase().contains(query);
        }).toList();
      }
      
      if (transaction.isNotEmpty) {
        state.copyWith(status: Status.success, transactionList: transaction);
      } else {
        state.copyWith(status: Status.failure, message: TextString.empty);
      }
    } else {
      state.copyWith(status: Status.failure, message: TextString.empty);
    }
  }

  Future<void> _onNextTransactionFetched(NextTransactionFetched event, Emitter<TransactionHistoryState> emit) async {
    
  }

  void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<TransactionHistoryState> emit) {
    final search = Search.dirty(event.searchQuery);
    emit(state.copyWith(searchQuery: search));
  }


}