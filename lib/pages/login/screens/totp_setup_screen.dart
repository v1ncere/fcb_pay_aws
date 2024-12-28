import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../login.dart';
import '../widgets/widgets.dart';

class TotpSetupScreen extends StatelessWidget {
  const TotpSetupScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final details = state.totpDetails!.getSetupUri(appName: 'FCBPay');
        final secret = state.totpDetails!.sharedSecret;
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Scan the QR code below in your authenticator app."),
              QrImageView(
                data: details.toString(),
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 20),
              const Text("Or enter this code manually: "),
              SelectableText(
                secret,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const ConfirmationInput(),
              const ConfirmSubmit(),
            ]
          )
        );
      }
    );
  }
}