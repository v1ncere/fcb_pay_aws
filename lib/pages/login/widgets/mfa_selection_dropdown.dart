import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class MfaSelectionDropdown extends StatelessWidget {
  const MfaSelectionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true, // this will align the menu to the button
            child: DropdownButtonFormField<MfaType>(    
              hint: const Text('Select a MFA'),
              borderRadius: BorderRadius.circular(15),
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none)
              ),
              onChanged: (value) => context.read<LoginBloc>().add(LoginMfaChanged(value!)),
              items: state.mfaTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name)
                );
              }).toList()
            )
          )
        );
      }
    );
  }
}