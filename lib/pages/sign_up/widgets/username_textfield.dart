import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../sign_up.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your username here', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            TextFormField(
              controller: state.usernameController,
              keyboardType: TextInputType.name,
              onChanged: (value) => context.read<SignUpBloc>().add(UsernameChanged(value)),
              decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(),
                label: const Text('Username'),
                errorText: state.username.displayError?.text(),
                suffixIcon: !state.username.isPure
                ? IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    iconSize: 18,
                    onPressed: () => context.read<SignUpBloc>().add(UsernameTextErased())
                  )
                : null,
              ),
              style: const TextStyle(height: 1.5),
            )
          ]
        );
      }
    );
  }
}