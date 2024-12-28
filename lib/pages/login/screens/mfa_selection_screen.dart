import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class MfaSelectionScreen extends StatelessWidget {
  const MfaSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(AssetString.otpSVG, height: 120),
              const SizedBox(height: 20),
              Text(
                'Please choose the MFA type',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const MfaSelectionDropdown(),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInText(text: 'Confirm'),
                  ConfirmSubmit(),
                ]
              )
            ]
          )
        )
      )
    );
  }
}