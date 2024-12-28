import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../account_viewer.dart';
import 'widgets.dart';

class CarouselSliderView extends StatelessWidget {
  const CarouselSliderView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const CarouselShimmer();
        }
        if (state.status.isSuccess) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    final account = state.accountList[index];
                    context.read<CarouselCubit>() // cascade methods for concise implementation
                    ..setSlideIndex(index: index)
                    ..setAccount(account: account);
                    context.read<TransactionHistoryBloc>().add(TransactionHistoryLoaded(accountID: account.accountNumber));
                  }
                ),
                items: state.accountList.map((data) {
                  if(data.category == 'credit') {
                    return CardCredit(
                      cardExpiration: getDateString(data.expiry!.getDateTimeInUtc()),
                      cardHolder: data.ownerName!,
                      type: data.type!,
                      cardNumber: data.accountNumber,
                      onTap: () {
                        // timer paused, to halt the navigation process
                        context.read<InactivityCubit>().pauseTimer();
                        context.replaceNamed(RouteName.account, extra: data);
                      }
                    );
                  }
                  if (data.category == 'deposit' || data.type == 'wallet') {
                    return DepositsCard(
                      cardHolder: data.ownerName!,
                      cardNumber: data.accountNumber,
                      type: data.type!,
                      onTap: () {
                        // timer paused, to halt the navigation process
                        context.read<InactivityCubit>().pauseTimer();
                        context.replaceNamed(RouteName.account, extra: data);
                      }
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }).toList()
              ),
              // page indicator, circle under carousel
              pagerIndicator(state: state)
            ]
          );
        }
        if (state.status.isFailure) {
          return CardError(text: state.message);
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}