part of 'accounts_home_bloc.dart';

sealed class AccountsHomeEvent extends Equatable {
  const AccountsHomeEvent();

  @override
  List<Object> get props => [];
}

final class AccountsHomeFetched extends AccountsHomeEvent {}

final class AccountsHomeUpdated extends AccountsHomeEvent {
  const AccountsHomeUpdated(this.accountList);
  final List<Account> accountList;

  @override
  List<Object> get props => [accountList];
}

final class DepositDisplayChanged extends AccountsHomeEvent {
  const DepositDisplayChanged(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class CreditDisplayChanged extends AccountsHomeEvent {
  const CreditDisplayChanged(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class UserAttributesFetched extends AccountsHomeEvent {}

final class AccountsHomeRefreshed extends AccountsHomeEvent {}
