import 'package:fcb_pay_aws/pages/update_password/widgets/current_password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../update_password.dart';
import '../widgets/widgets.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Update Password',
            style: TextStyle(
              color: ColorString.jewel,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            IconButton(
              onPressed: () => context.goNamed(RouteName.authPin),
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ]
        ),
        body: BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                customSnackBar(
                  text: state.message ?? '',
                  icon: FontAwesomeIcons.triangleExclamation,
                  backgroundColor: ColorString.guardsmanRed,
                  foregroundColor: ColorString.mystic
                )
              );
            }
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                text: 'Password Update Successful!',
                icon: FontAwesomeIcons.circleCheck,
                backgroundColor: ColorString.eucalyptus,
                foregroundColor: ColorString.mystic
              ));
              context.goNamed(RouteName.settings);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              color: ColorString.jewel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    CurrentPasswordTextField(),
                    SizedBox(height: 10),        
                    NewPasswordTextField(),
                    SizedBox(height: 10),  
                    ConfirmNewPasswordTextField(),
                    SizedBox(height: 20),                              
                    UpdatePasswordButton(),
                    SizedBox(height: 10)
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}
