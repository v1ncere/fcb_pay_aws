import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetString.profileData, height: 120),
              const SizedBox(height: 15),
              Text(
                'Please reset your password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const PasswordInput(),
              const SizedBox(height: 15),
              const PasswordInputConfirm(),
              const SizedBox(height: 15),
              const ConfirmationInput(),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInText(text: 'Confirm'),
                  ConfirmSubmit()
                ]
              )
            ]
          )
        )
      )
    );
  }
}