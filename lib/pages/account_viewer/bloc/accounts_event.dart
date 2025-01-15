part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class AccountsFetched extends AccountsEvent {
  const AccountsFetched(this.account);
  final Account account;

  @override 
  List<Object> get props => [account];
}

final class AccountsRefreshed extends AccountsEvent {
  const AccountsRefreshed(this.account);
  final Account account;

  @override 
  List<Object> get props => [account];
}

final class AccountsBalanceRequested extends AccountsEvent {
  const AccountsBalanceRequested(this.account);
  final Account account;

  @override
  List<Object> get props => [account];
}