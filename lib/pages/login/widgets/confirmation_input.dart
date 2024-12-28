import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../login.dart';
import '../../../utils/utils.dart';

class ConfirmationInput extends StatelessWidget {
  const ConfirmationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.pinCode != current.pinCode,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<LoginBloc>().add(PinCodeChanged(value)),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 211, 243, 224),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
              FontAwesomeIcons.solidCircleUser,
              color: ColorString.eucalyptus
            ),
            labelText: 'Confirmation code',
            errorText: state.pinCode.displayError?.text(),
            border: SelectedInputBorderWithShadow(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
          )
        );
      },
    );
  }
}