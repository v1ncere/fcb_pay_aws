import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../account_viewer.dart';
import 'widgets.dart';

class GridViewButtons extends StatelessWidget {
  const GridViewButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountButtonBloc, AccountButtonState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const ButtonShimmer();
        }
        if (state.status.isSuccess) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: constraints.maxWidth > 400 ? 4 : 3), // larger width screen the more the button display
                shrinkWrap: true,
                itemCount: state.buttonList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final button = state.buttonList[index];
                  return CircleButtonWithLabel(
                    icon: iconMapper(button.icon!),
                    color: colorStringParser(button.iconColor!),
                    text: button.title!,
                    onTap: () {
                      // TODO: 
                      // context.read<RouterBloc>().add(RouterAccountsButtonPassed(button));
                      // context.flow<HomeRouterStatus>().update((next) => HomeRouterStatus.accountsViewer);
                    }
                  );
                }
              );
            }
          );
        }
        if (state.status.isFailure) {
          return Center(child: Text(state.message));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}