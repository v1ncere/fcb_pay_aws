import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../local_authentication.dart';
import '../widgets/widgets.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextString.setupPin,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF687ea1)
          )
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.x, 
              size: 18,
              color: Color(0xFF687ea1)
            ),
            onPressed: () async => context.pop(),
          )
        ],
        automaticallyImplyLeading: false
      ),
      body: BlocListener<CreatePinBloc, CreatePinState>(
        listener: (context, state) {
          // pinCode create successful
          if (state.status.isEquals) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              text: TextString.confirmPinSuccess,
              icon: FontAwesomeIcons.solidCircleCheck,
              backgroundColor: ColorString.eucalyptus,
              foregroundColor: ColorString.mystic,
            ));
            context.replaceNamed(RouteName.authPin);
          }
          // pinCode unequals
          if (state.status.isUnequals) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              text: TextString.confirmPinFailure,
              icon: FontAwesomeIcons.triangleExclamation,
              backgroundColor: ColorString.guardsmanRed,
              foregroundColor: ColorString.mystic,
            ));
          }
        },
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 2, child: InputPin()),
            Expanded(flex: 3, child: NumPad())
          ]
        )
      )
    );
  }
}
