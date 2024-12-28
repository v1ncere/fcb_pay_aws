import 'package:fcb_pay_aws/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InactivityDetector(
        onInactive: () => context.goNamed(RouteName.authPin),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700
              )
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () => context.goNamed(RouteName.bottomNavbar), 
                icon: const Icon(FontAwesomeIcons.x, size: 18)
              )
            ]
          ),
          body: const Column(
            children: [
              SizedBox(height: 10),
              ContainerBody(
                children: [
                  NotificationList()
                ]
              )
            ]
          )
        )
      )
    );
  }
}