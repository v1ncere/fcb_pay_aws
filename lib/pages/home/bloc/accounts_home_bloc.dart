import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'accounts_home_event.dart';
part 'accounts_home_state.dart';

final Account emptyAccount = Account(accountNumber: '');

class AccountsHomeBloc extends Bloc<AccountsHomeEvent, AccountsHomeState> {
  AccountsHomeBloc({
    required HiveRepository hiveRepository,
  }) : _hiveRepository = hiveRepository,
  super(AccountsHomeState(credit: emptyAccount, deposit: emptyAccount, wallet: emptyAccount)) {
    on<UserAttributesFetched>(_onUserAttributesFetched);
    on<AccountsHomeFetched>(_onAccountsHomeLoaded);
    on<DepositDisplayChanged>(_onDepositDisplayChanged);
    on<CreditDisplayChanged>(_onCreditDisplayChanged);
    on<AccountsHomeRefreshed>(_onAccountsHomeRefreshed);
  }
  final HiveRepository _hiveRepository;

  Future<void>  _onAccountsHomeLoaded(AccountsHomeFetched event, Emitter<AccountsHomeState> emit) async {
    await _fetchDataAndRefreshState(emit);
  }

  Future<void> _onUserAttributesFetched(UserAttributesFetched event, Emitter<AccountsHomeState> emit) async {
    await _fetchUserDetails(emit);
  }

  // change deposit display
  Future<void> _onDepositDisplayChanged(DepositDisplayChanged event, Emitter<AccountsHomeState>  emit) async {
    emit(state.copyWith(status: Status.loading)); // emit status loading
    _hiveRepository.addDepositId(uid: state.uid, account: event.id); // save id into local storage using [hive]
    await _fetchDataAndRefreshState(emit); // refresh the state
  }

  // change credit display
  Future<void> _onCreditDisplayChanged(CreditDisplayChanged event, Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(status: Status.loading)); // emit status loading
    _hiveRepository.addCreditId(uid: state.uid, account: event.id); // save id into local storage using [hive]
    await _fetchDataAndRefreshState(emit); // refresh the state
  }

  // refresh the state
  Future<void> _onAccountsHomeRefreshed(AccountsHomeRefreshed event, Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(status: Status.loading, userStatus: Status.loading)); // emit status loading
    await _fetchUserDetails(emit);
    await _fetchDataAndRefreshState(emit); // refresh the state
  }

  // UTILITY METHODS ===============================================================================
  // fetching list of accounts from AWS
  Future<void> _fetchDataAndRefreshState(Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    if (await checkNetworkStatus()) {
      try {
        final user = await Amplify.Auth.getCurrentUser();
        final request = ModelQueries.list(Account.classType, where: Account.OWNER.eq(user.userId), authorizationMode: APIAuthorizationType.iam);
        final response = await Amplify.API.query(request: request).response;
        final items = response.data?.items;
        // check if the response is not null
        if (items == null) {
          emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
        } else {
          final accountList = items.whereType<Account>().toList();
          Account wallet = _getAccountOfCategory(accountList, 'wallet'); // locate the wallet account
          Account deposit = await _getDepositAccount(accountList); // locate the deposit account
          Account credit = await _getCreditAccount(accountList); // locate the credit account


          emit(state.copyWith(status: Status.success, accountList: accountList, wallet: wallet, deposit: deposit, credit: credit));
        }
      } on AuthException catch (e) {
        emit(state.copyWith(status: Status.failure, message: e.message));
      } on ApiException catch (e) {
        emit(state.copyWith(status: Status.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: Status.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: Status.failure, message: TextString.internetError));
    }
  }

  Future<void> _fetchUserDetails(Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(userStatus: Status.loading));
    final isConnected = await checkNetworkStatus();
    if (isConnected) {
      try {
        final result = await Amplify.Auth.fetchUserAttributes();
        final sub = result.firstWhere((e) => e.userAttributeKey == AuthUserAttributeKey.sub);
        final givenName = result.firstWhere((e) => e.userAttributeKey == AuthUserAttributeKey.givenName);
        emit(state.copyWith(userStatus: Status.success, username: givenName.value, uid: sub.value));
      } on AuthException catch (e) {
        emit(state.copyWith(userStatus: Status.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(userStatus: Status.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(userStatus: Status.failure, message: TextString.internetError));
    }
  }

  // get the category of the Account
  Account _getAccountOfCategory(List<Account> accountList, String category) {
    return accountList.firstWhere((account) => account.category!.toLowerCase() == category, orElse: () => emptyAccount);
  }

  // sort the list of Accounts and return the  latest
  Account getLatestAccount(List<Account> accountList, String category) {
    accountList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return accountList.firstWhere((e) => e.category?.toLowerCase() == category);
  }

  // get the specific "deposit" account
  Future<Account> _getDepositAccount(List<Account> accountList) async {
    final deposit = accountList.where((account) => account.category?.toLowerCase() == 'deposit');
    if(deposit.isNotEmpty) {
      final id = await _hiveRepository.getDepositId(state.uid); // id/account number saved from local storage [hive]
      return id.isNotEmpty
      ? accountList.firstWhere((account) => account.accountNumber == id) // if id is not empty, locate the account equals to the id
      : getLatestAccount(accountList, 'deposit'); // if id is empty get the latest account
    }
    return emptyAccount;
  }

  // get the specific "credit" account
  Future<Account> _getCreditAccount(List<Account> accountList) async {
    final credit = accountList.where((account) => account.category?.toLowerCase() == 'credit');
    if(credit.isNotEmpty) {
      final id = await _hiveRepository.getCreditId(state.uid); // id/accountId saved from local storage [hive]
      return id.isNotEmpty
      ? accountList.firstWhere((account) => account.accountNumber == id) // if id is not empty, locate the account equals to the id
      : getLatestAccount(accountList, 'credit'); // if id is empty get the latest account
    }
    return emptyAccount;
  }
}
