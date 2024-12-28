import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_aws/repository/repository.dart';

import '../sign_up_verify.dart';

class SignUpVerifyPage extends StatelessWidget {
  const SignUpVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpVerifyBloc(amplifyData: AmplifyData()),
      child: const SignUpVerifyView()
    );
  }
}