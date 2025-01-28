import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../home/home.dart';
import '../scanner_transaction.dart';

class ScannerTransactionPage extends StatelessWidget {
  const ScannerTransactionPage({super.key});
   static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hiveRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AccountsHomeBloc(hiveRepository: _hiveRepository)
          ..add(AccountsHomeFetched())),
          BlocProvider(create: (context) => ScannerTransactionBloc(hiveRepository: _hiveRepository)
          ..add(ScannerTransactionDisplayLoaded())
          ..add(ScannerCurrentUserFetched()))
        ],
        child: const ScannerTransactionView()
      )
    );
  }
}