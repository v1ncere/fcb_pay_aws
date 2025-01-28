// Amplify graphql
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../home/home.dart';
import '../../payments/payments.dart';
import '../../transfers/transfers.dart';
import '../bottom_navbar.dart';

class BottomNavbarPage extends StatelessWidget {
  const BottomNavbarPage({super.key});
  // under this nav dont create another .page()
  static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountsHomeBloc(hiveRepository: _hiveRepository)
        ..add(UserAttributesFetched())
        ..add(AccountsHomeFetched())),
        BlocProvider(create: (context) => PaymentButtonsBloc()
        ..add(PaymentButtonsFetched())),
        BlocProvider(create: (context) => TransferButtonsBloc()
        ..add(TransferButtonsFetched())),
        BlocProvider(create: (context) => BottomNavbarCubit()),
      ],
      child: const BottomNavbarView()
    );
  }
}