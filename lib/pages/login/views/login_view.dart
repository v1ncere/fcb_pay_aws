
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
  
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../login.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState> (
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.goNamed(RouteName.authPin);
          // context.read<AppBloc>().add(LoginChecked());
        }
        if(state.status.isCanceled) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.solidCircleCheck,
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: ColorString.mystic,
          ));
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic,
          ));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: LoadingStack(
            isLoading: state.status.isInProgress,
            child: Scaffold(
              body: switch(state.signInSteps) {
                SignInSteps.initial => const LoginScreen(),
                SignInSteps.confirmSignInWithSmsMfaCode => const ConfirmScreen(),
                SignInSteps.confirmSignInWithTotpMfaCode => const ConfirmScreen(),
                SignInSteps.confirmSignInWithNewPassword => const NewPasswordScreen(),
                SignInSteps.confirmSignInWithCustomChallenge => const LoginScreen(),
                SignInSteps.continueSignInWithMfaSelection => const MfaSelectionScreen(),
                SignInSteps.continueSignInWithTotpSetup => const TotpSetupScreen(),
                SignInSteps.resetPassword => const ResetPasswordScreen(),
                SignInSteps.confirmSignUp => const ConfirmScreen(),
                SignInSteps.done => const LoginScreen(),
              }
            )
          )
        );
      }
    );
  }
}