import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../re_authenticate.dart';
import '../widgets/widgets.dart';

class ReauthenticateView extends StatelessWidget {
  const ReauthenticateView({super.key});

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LOGIN'),
        ),
        body: BlocListener<ReAuthBloc, ReAuthState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                customSnackBar(
                  text: state.message,
                  icon: FontAwesomeIcons.triangleExclamation,
                  backgroundColor: ColorString.guardsmanRed,
                  foregroundColor: ColorString.mystic
                )
              );
            }
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                customSnackBar(
                  text: state.message,
                  icon: FontAwesomeIcons.triangleExclamation,
                  backgroundColor: ColorString.eucalyptus,
                  foregroundColor: ColorString.mystic
                )
              );
              // TODO: 
              // context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.updatePassword);
            }
          },
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmailDialogInput(),
                  SizedBox(height: 10),
                  PasswordDialogInput(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ReAuthenticateButton()
                    ]
                  )
                ]
              )
            ),
          )
        )
      ),
    );
  }
}