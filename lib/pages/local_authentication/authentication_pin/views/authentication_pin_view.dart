import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../local_authentication.dart';
import '../widgets/widgets.dart';

class AuthPinView extends StatelessWidget {
  const AuthPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [AppbarTrailingButton()]
      ),
      body: MultiBlocListener(
        listeners: [
          // listen to fingerprint biometric
          BlocListener<BiometricCubit, BiometricState>(
            listener: (context, state) {
              // fingerprint success
              if (state.status.isAuthenticated) {
                context.goNamed(RouteName.bottomNavbar);
              }
              // fingerprint fail
              if (state.status.isUnauthenticated) {
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBar(
                  text: state.message,
                  icon: FontAwesomeIcons.triangleExclamation,
                  backgroundColor: ColorString.guardsmanRed,
                  foregroundColor: ColorString.mystic,
                ));
              }
            }
          ),
          // listen to pin code
          BlocListener<AuthPinBloc, AuthPinState>(
            listener: (context, state) {
              // pinCode correct
              if (state.status.isEquals) {
                context.goNamed(RouteName.bottomNavbar);
              }
              // pinCode incorrect
              if (state.status.isUnequals) {
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBar(
                  text: TextString.authenticationFailure,
                  icon: FontAwesomeIcons.triangleExclamation,
                  backgroundColor: ColorString.guardsmanRed,
                  foregroundColor: ColorString.mystic,
                ));
              }
            }
          )
        ],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const UserAccount(),
            const Expanded(
              flex: 2, 
              child: InputPin()
            ),
            BlocSelector<BiometricCubit, BiometricState, bool>(
              selector: (state) => state.biometricsEnabled,
              builder: (context, isEnabled) {
                return Expanded(
                  flex: 4,
                  child: NumPad(isBiometricEnable: isEnabled)
                );
              }
            )
          ]
        )
      )
    );
  }
}