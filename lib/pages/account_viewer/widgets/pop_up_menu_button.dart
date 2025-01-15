import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../account_viewer.dart';

class PopUpMenuButton extends StatelessWidget {
  const PopUpMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state.filterStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(left: 14, right: 14),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 3)
            )
          );
        }
        if (state.filterStatus.isSuccess) {
          return BlocSelector<CarouselCubit, CarouselState, Account>(
            selector: (state) => state.account,
            builder: (_, account) {
              return PopupMenuButton(
                icon: Icon(
                  FontAwesomeIcons.filter,
                  color: Colors.green,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1.5)
                    )
                  ]
                ),
                onSelected: (value) {
                  context.read<TransactionHistoryBloc>().add(TransactionHistoryLoaded(accountID: account.accountNumber, filter: value));
                },
                itemBuilder: (BuildContext context) {
                  return state.filters.map((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value.toLowerCase())
                    );
                  }).toList();
                }
              );
            }
          );
        }
        if (state.filterStatus.isFailure) {
          return Center(child: Text(state.message));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}