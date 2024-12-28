import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../account_viewer.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransactionHistoryBloc()
        ..add(TransactionHistoryLoaded(accountID: account.accountNumber))),
        BlocProvider(create: (context) => FilterBloc()
        ..add(FilterFetched())),
        BlocProvider(create: (context) => AccountButtonBloc()
        ..add(ButtonsFetched(account.type!))),
        BlocProvider(create: (context) => AccountsBloc()
        ..add(FetchUserUID())
        ..add(AccountsFetched(account))),
        BlocProvider(create: (context) => CarouselCubit()..setAccount(account: account)),
      ],
      child: AccountView(account: account)
    );
  }
}