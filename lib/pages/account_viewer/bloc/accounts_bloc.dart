import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(const AccountsState()) {
    on<AccountsFetched>(_onAccountsLoaded);
    on<AccountsRefreshed>(_onAccountsRefreshed);
    on<AccountsBalanceRequested>(_onAccountsBalanceRequested);
  }

  Future<void> _onAccountsLoaded(AccountsFetched event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final isConnected = await checkNetworkStatus();
    if (isConnected) {
      final user = await Amplify.Auth.getCurrentUser();
      final request = ModelQueries.list(Account.classType, where: Account.OWNERID.eq(user.userId));
      final response = await Amplify.API.query(request: request).response;
      final accounts = response.data?.items;
      
      if (accounts == null || accounts.isEmpty) {
        emit(state.copyWith(status: Status.failure, message: 'No accounts found'));
      } else {
        final accountList = accounts.whereType<Account>().toList();
        final sameCategory = accountList.where((e) => e.category == event.account.category).toList();
        // Account specified by user to display first
        final first = sameCategory.firstWhere((e) => e.accountNumber == event.account.accountNumber);
        // other Accounts remaining
        final others = sameCategory.where((e) => e.accountNumber != event.account.accountNumber).toList();
        // sort the accounts
        final sortedAccountList = [ first, ...others ];
        emit(state.copyWith(status: Status.success, accountList: sortedAccountList));
      }      
    } else {
      emit(state.copyWith(status: Status.failure, message: TextString.internetError));
    }
  }

  Future<void> _onAccountsBalanceRequested(AccountsBalanceRequested event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(requestStatus: Status.loading));
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final request = ModelMutations.create(Request(
        data: 'request_balance|${event.account.accountNumber}|hashed_data_for_security',
        verifier: '', 
        ownerId: user.userId
      ));

      final response = await Amplify.API.mutate(request: request).response;
      if(response.hasErrors) {
        emit(state.copyWith(requestStatus: Status.failure, message: response.errors.join(', ')));
      } else {
        emit(state.copyWith(requestStatus: Status.success));
      }
    } on ApiException catch (e) {
       emit(state.copyWith(requestStatus: Status.failure, message: e.message));
    } catch (e) {
       emit(state.copyWith(requestStatus: Status.failure, message: e.toString()));
    }
  }

  void _onAccountsRefreshed(AccountsRefreshed event, Emitter<AccountsState> emit) {
    add(AccountsBalanceRequested(event.account)); // balance request
    add(AccountsFetched(event.account)); // actual refresh data
  }
}
