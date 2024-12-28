import 'package:fcb_pay_aws/pages/sign_up_confirm/sign_up_confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SignUpConfirmView extends StatelessWidget{
  const SignUpConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpConfirmBloc, SignUpConfirmState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.goNamed(RouteName.login);
        }
        if (state.status.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.x, size: 16),
              onPressed: () => context.pop()
            )
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade50,
                    ),
                    child: SvgPicture.asset(AssetString.otpSVG)
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter the OTP send to your email',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const PinInputs(),
                  const SizedBox(height: 25)
                ]
              )
            )
          )
        )
      )
    );
  }

  // UTILITY METHODS
  // =========================================================
  // show failure snackbar
  _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.white
    ));
  }
}