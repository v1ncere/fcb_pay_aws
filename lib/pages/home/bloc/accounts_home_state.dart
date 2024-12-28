part of 'accounts_home_bloc.dart';

class AccountsHomeState extends Equatable {
  const AccountsHomeState({
    this.accountList = const <Account>[],
    required this.wallet,
    required this.deposit,
    required this.credit,
    this.username = '',
    this.uid = '',
    this.status = Status.initial,
    this.userStatus = Status.initial,
    this.message = ''
  });
  final List<Account> accountList;
  final Account wallet;
  final Account deposit;
  final Account credit;
  final String username;
  final String uid;
  final Status status;
  final Status userStatus;
  final String message;
  
  AccountsHomeState copyWith({
    List<Account>? accountList,
    Account? wallet, 
    Account? deposit,
    Account? credit,
    String? username,
    String? uid,
    Status? status,
    Status? userStatus,
    String? message,
  }) {
    return AccountsHomeState(
      accountList: accountList ?? this.accountList,
      wallet: wallet ?? this.wallet,
      deposit: deposit ?? this.deposit,
      credit: credit ?? this.credit,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      userStatus: userStatus ?? this.userStatus,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [
    accountList,
    wallet,
    deposit,
    credit,
    username,
    uid,
    status,
    userStatus,
    message,
  ];
}
