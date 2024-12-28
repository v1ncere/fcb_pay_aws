import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local_authentication.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCheckerBloc, AuthCheckerState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'user:',
              style: TextStyle(color: Color(0xFF687ea1))
            ),
            Text(
              state.userName,
              style: const TextStyle(
                color: Color(0xFF687ea1),
                fontWeight: FontWeight.w900,
                fontSize: 16
              )
            )
          ]
        );
      }
    );
  }
}