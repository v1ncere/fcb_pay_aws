import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/utils.dart';
import '../authentication_pin.dart';

class AppbarTrailingButton extends StatelessWidget {
  const AppbarTrailingButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCheckerBloc, AuthCheckerState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: SpinKitChasingDots(
              color: Colors.white,
              size: 18,
            )
          );
        }
        if (state.status.isSuccess) {
          return state.isPinExist
          ? TextButton(
              onPressed: () => context.pushNamed(RouteName.updatePin),
              child: Text(
                TextString.updatePin,
                style: TextStyle(
                  color: ColorString.blazeOrange,
                  fontWeight: FontWeight.bold
                )
              )
            )
          : TextButton(
              onPressed: () => context.pushNamed(RouteName.createPin),
              child: Text(
                TextString.createPin,
                style: TextStyle(
                  color: ColorString.jewel,
                  fontWeight: FontWeight.bold
                )
              )
            );
        }
        if (state.status.isFailure) {
          return const Center(child: Text('Error Occurred'));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}