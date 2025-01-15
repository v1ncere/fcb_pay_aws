import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../account_viewer.dart';
import '../widgets/widgets.dart';

class AccountViewerView extends StatelessWidget {
  const AccountViewerView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            account.category!.toUpperCase(),
            style: TextStyle(
              color: ColorString.jewel,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ],
          automaticallyImplyLeading: false
        ),
        body: RefreshIndicator(
          onRefresh: () async => context.read<AccountsBloc>().add(AccountsRefreshed(account)),
          child: ListView(
            children: [
              const CarouselSliderView(),
              const SizedBox(height: 10),
              const AccountDetailsView(),
              const SizedBox(height: 10),
              const ActionButtonView(),
              const SizedBox(height: 20),
              TransactionHistoryView(account: account),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25)
            ]
          )
        )
      )
    );
  }
}