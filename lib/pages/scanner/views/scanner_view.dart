import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../scanner.dart';
import '../widgets/widgets.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});
  
  @override
  State<ScannerView> createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> {
  final _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.normal
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    double area = screen.width < 400 || screen.height < 400 ? 250.0 : 360.0;
    // final scanWindow = Rect.fromLTWH((screen.width - area)/ 2, (screen.height - area)/ 2, area, area);
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: area,
      height: area,
    );
    return InactivityDetector(
      onInactive: () {
        context.goNamed(RouteName.authPin);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'QR SCANNER', 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [toggleTorch()]
        ),
        body: BlocListener<ScannerCubit, ScannerState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.pushNamed(RouteName.scannerTransaction);
            }
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Stack(
            children: [
              MobileScanner(
                controller: _controller,
                placeholderBuilder: (_, __) => Container(color: Colors.black),
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error, area: area);
                },
                scanWindow: scanWindow,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    context.read<ScannerCubit>().saveQRCode(barcode.rawValue!);
                  }
                }
              ),
              CustomPaint(painter: ScannerOverlay(scanWindow)),
              // Positioned.fill(
              //   child: Container(
              //     decoration: ShapeDecoration(
              //       shape: QrScannerOverlayShape(
              //         borderColor: const Color(0xFF02AE08),
              //         borderRadius: 10,
              //         borderLength: 20,
              //         borderWidth: 8,
              //         cutOutSize: area
              //       )
              //     )
              //   )
              // ),
              const ScannerText()
            ]
          )
        )
      ),
    );
  }

  Widget toggleTorch() {
    return  IconButton(
      color: Colors.white,
      iconSize: 32.0,
      icon: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, state, child) {
          if (!state.isInitialized || !state.isRunning) {
            return const SizedBox.shrink();
          }

          switch (state.torchState) {
            case TorchState.auto:
              return const Icon(
                Icons.flash_auto_rounded,
                size: 18,
                color:Colors.grey
              );
            case TorchState.off:
              return const Icon(
                Icons.flash_on_rounded,
                size: 18,
                color:Colors.grey
              );
            case TorchState.on:
              return const Icon(
                Icons.flash_off_rounded,
                size: 18, 
                color:Colors.yellow
              );
            case TorchState.unavailable:
              return const Icon(
                Icons.no_flash_rounded,
                size: 18, 
                color:Colors.grey
              );
          }
        }
      ),
      onPressed: () => _controller.toggleTorch()
    );
  }
}