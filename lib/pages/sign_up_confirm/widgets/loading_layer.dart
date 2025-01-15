import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/utils.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    super.key, 
    required this.child,
    required this.isLoading, 
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height * 0.2;
    final double containerWidth = MediaQuery.of(context).size.width * 0.40;
    return Stack(
      children: [
        child,
        if(isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: Center(
                child: _buildProgressDialog(context, containerHeight, containerWidth),
              )
            )
          )
      ]
    );
  }

  Widget _buildProgressDialog(BuildContext context, double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: _buildLoadingIndicator(),
      )
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SpinKitThreeBounce(
          color: Colors.white,
          size: 30,
        ),
        Text(
          'loading...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorString.white,
          )
        )
      ]
    );
  }
}
