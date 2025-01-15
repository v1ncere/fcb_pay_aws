import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../login.dart';

class ConfirmSubmit extends StatelessWidget {
  const ConfirmSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 0.3,
                blurRadius: 2,
                offset: const Offset(0, 1)
              )
            ]
          ),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Material(
              color:const Color(0xFF25C166),
              child: InkWell(
                splashColor: Colors.white38,
                onTap: () => context.read<LoginBloc>().add(const ConfirmSubmitted()), 
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: state.status.isInProgress
                  ? const CircularProgressIndicator() 
                  : const Icon(
                    FontAwesomeIcons.check,
                    color: Colors.white
                  )
                )
              )
            )
          )
        );
      }
    );
  }
}