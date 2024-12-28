import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../receipt.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});
  static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hiveRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReceiptBloc(hiveRepository: _hiveRepository)
            ..add(ReceiptDisplayStreamed()),
          ),
          BlocProvider(create: (context) => SaveReceiptCubit())
        ],
        child: const ReceiptView()
      )
    );
  }
}