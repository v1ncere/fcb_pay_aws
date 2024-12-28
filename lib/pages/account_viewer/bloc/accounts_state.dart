part of 'accounts_bloc.dart';

class AccountsState extends Equatable {
  const AccountsState({
    this.accountList = const <Account>[],
    this.uid = '',
    this.userStatus = Status.initial,
    this.status = Status.initial,
    this.requestStatus = Status.initial,
    this.message = '',
  });
  final List<Account> accountList;
  final String uid;
  final Status userStatus;
  final Status status;
  final Status requestStatus;
  final String message;

  AccountsState copyWith({
    List<Account>? accountList,
    String? uid,
    Status? userStatus,
    Status? status,
    Status? requestStatus,
    String? message,
  }) {
    return AccountsState(
      accountList: accountList ?? this.accountList,
      uid: uid ?? this.uid,
      userStatus: userStatus ?? this.userStatus,
      status: status ?? this.status,
      requestStatus: requestStatus ?? this.requestStatus,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [accountList, uid, userStatus, requestStatus, status, message];
}