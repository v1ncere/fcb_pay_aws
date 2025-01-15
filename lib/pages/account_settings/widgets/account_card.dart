import 'package:flutter/material.dart';

import 'widgets.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.icon,
    required this.account,
    required this.colors
  });
  final IconData icon;
  final String account;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87, // Shadow color
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                Flexible(
                  child: FittedBox(
                    child: Text(account,
                      textAlign: TextAlign.center,
                      style:  const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black87, // Shadow color
                            blurRadius: 3,
                            offset: Offset(0, 1.5)
                          )
                        ]
                      )
                    )
                  )
                ),
                PopUpSettingsButton(account: account)
              ]
            )
          )
        )
      )
    );
  }
}