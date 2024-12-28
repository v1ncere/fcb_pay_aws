import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Align(
        alignment: const Alignment(0, -1/3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AssetString.profileData, height: 120),
              const SizedBox(height: 16),
              const EmailInput(),
              const SizedBox(height: 12),
              const PasswordInput(),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInText(text: 'Sign In'),
                  LoginButton()
                ]
              ),
              Divider(
                endIndent: MediaQuery.of(context).size.width * 0.35,
                indent: MediaQuery.of(context).size.width * 0.35,
                color: ColorString.algaeGreen,
              ),
              const SignUpButton(),
            ]
          )
        )
      )
    );
  }
}