import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../bottom_navbar.dart';

BottomAppBar bottomNavAppBar({
  required BottomNavbarTab tab,
  required PageController controller
}) {
  return BottomAppBar(
    color: ColorString.emerald,
    shape: const CircularNotchedRectangle(),
    notchMargin: 5,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        iconButton(
          groupValue: tab,
          value: BottomNavbarTab.home,
          controller: controller,
          icon: Icon(
            FontAwesomeIcons.creditCard, 
            shadows: tab.isHome
            ? [Shadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4.0)]
            : null
          )
        ),
        iconButton(
          groupValue: tab,
          value: BottomNavbarTab.payments,
          controller: controller,
          icon: Icon(
            FontAwesomeIcons.receipt,
            shadows: tab.isPayments
            ? [Shadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4.0)]
            : null
          )
        ),
        const SizedBox(width: 40),
        iconButton(
          groupValue: tab,
          value: BottomNavbarTab.transfers,
          controller: controller,
          icon: Icon(
            FontAwesomeIcons.moneyBillTransfer,
            shadows: tab.isTransfers
            ? [Shadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4.0)]
            : null
          )
        ),
        iconButton(
          groupValue: tab,
          value: BottomNavbarTab.accounts,
          controller: controller,
          icon: Icon(
            FontAwesomeIcons.barsStaggered,
            shadows: tab.isAccounts
            ? [Shadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4.0)]
            : null
          )
        )
      ]
    )
  );
}