import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../account_settings/account_settings.dart';
import '../../home/home.dart';
import '../../payments/payments.dart';
import '../../scanner/scanner.dart';
import '../../transfers/transfers.dart';
import '../bottom_navbar.dart';

class BottomNavbarView extends StatelessWidget {
  const BottomNavbarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomNavbarCubit, BottomNavbarTab, BottomNavbarTab>(
      selector: (state) => state,
      builder: (context, tab) {
        final controller = PageController(initialPage: tab.index);
        _inactivityResume(context);
        return InactivityDetector(
          onInactive: () => context.goNamed(RouteName.authPin),
          child: Scaffold(
            extendBody: true, // for QR scanner to occupy the whole screen
            drawer: const SideDrawer(),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) => context.read<BottomNavbarCubit>().setTab(BottomNavbarTab.values[index]),
              children: const [
                HomePage(),
                PaymentsPage(),
                ScannerPage(),
                TransfersPage(),
                AccountSettingsPage()
              ]
            ),
            bottomNavigationBar: bottomNavAppBar(tab: tab, controller: controller),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: centerFloatingActionButton(tab: tab, controller: controller)
          )
        );
      }
    );
  }
  // UTILITY METHODS
  void _inactivityResume(BuildContext context) => context.read<InactivityCubit>().resumeTimer();
}