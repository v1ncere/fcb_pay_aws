import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/Account.dart';
import '../../../utils/utils.dart';
import '../home.dart';
import 'widgets.dart';

class AccountsCardView extends StatelessWidget {
  const AccountsCardView({super.key});
  static final empty = Account(accountNumber: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) { 
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: CardShimmer(),
          );
        }
        if (state.status.isSuccess) {
          return ListView(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: [
              state.wallet == empty
              ? walletCard(context: context, account: state.wallet)
              : const SizedBox.shrink(),
              state.deposit == empty
              ? depositsCard(accountList: state.accountList, context: context, account: state.deposit)
              : const SizedBox.shrink(),
              state.credit == empty
              ? creditCard(accountList: state.accountList, context: context, account: state.credit)
              : const SizedBox.shrink(),
              const SizedBox(height: 150)
            ]
          );
        } 
        if (state.status.isFailure) {
          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      )
                    )
                  )
                )
              )
            ]
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}