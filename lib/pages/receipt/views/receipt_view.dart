import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../receipt.dart';
import '../widgets/widgets.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({super.key});
  static final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.x, size: 18),
              onPressed: () => context.goNamed(RouteName.bottomNavbar)
            )
          ]
        ),
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status.isSuccess) {
              return RepaintBoundary(
                key: _key,
                child: Column(
                  children: [
                    CustomCard(receipts: state.receiptMap),
                  ]
                )
              );
            }
            if (state.status.isFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black38)
                )
              );
            }
            else {
              return const SizedBox.shrink();
            }
          }
        ),
        bottomNavigationBar: ScreenshotButton(globalKey: _key)
      )
    );
  }
}