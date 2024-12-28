import 'package:flutter/material.dart';

import '../../../models/ModelProvider.dart';
import 'widgets.dart';

class TransactionHistoryView extends StatelessWidget {
  const TransactionHistoryView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction History',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w900
            )
          ),
          const Divider(color: Color(0xFF25C166)),
          const SizedBox(height: 10),
          const SearchBox(),
          const SizedBox(height: 10),
          TransactionHistoryList(account: account)
        ]
      )
    );
  }
}