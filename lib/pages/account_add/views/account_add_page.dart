import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account_add.dart';

class AccountAddPage extends StatelessWidget {
  const AccountAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountAddBloc(),
      child: const AccountAddView()
    );
  }
}