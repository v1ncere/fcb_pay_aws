import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../../app/widgets/widgets.dart';
import '../../../widgets/widgets.dart';
import '../notifications_viewer.dart';
import '../widgets/widgets.dart';

class NotificationsViewerView extends StatelessWidget {
  const NotificationsViewerView({super.key, required this.args});
  final String args;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InactivityDetector(
        onInactive: () {
          context.goNamed(RouteName.authPin);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Notification',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700
              )
            ),
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.trashCan, color: Color.fromARGB(255, 97, 97, 97)),
                onPressed: () {
                  context.read<NotificationsViewerBloc>().add(NotificationDelete(args));
                  context.pop();
                }
              )
            ]
          ),
          body: const Column(
            children: [
              SizedBox(height: 10),
              ContainerBody(
                children: [
                  NotificationDisplay()
                ]
              )
            ]
          ) 
        ),
      )
    );
  }
}