import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../re_authenticate.dart';

class ReauthenticatePage extends StatelessWidget {
  const ReauthenticatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReAuthBloc(),
      child: const ReauthenticateView()
    );
  }
}