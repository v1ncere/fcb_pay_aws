import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/utils.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    super.key, 
    required this.child,
    required this.isLoading, 
    required this.isProgress,
    required this.progress,
  });
  final Widget child;
  final bool isLoading;
  final bool isProgress;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.2;
    final width = MediaQuery.of(context).size.width * 0.40;
    return Stack(
      children: [
        child,
        if(isProgress || isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: Center(
                child: _buildProgressDialog(context, height, width)
              )
            )
          )
      ]
    );
  }
  
  // LOADING/PROGRESS DIALOG
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
        child: isLoading ? _buildLoadingIndicator() : _buildProgressIndicator(),
      )
    );
  }

  // PROGRESS INDICATOR
   Widget _buildProgressIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircularProgressIndicator.adaptive(
          value: progress,
          strokeWidth: 5.0,
          backgroundColor: Colors.grey,
          valueColor: const AlwaysStoppedAnimation(Colors.white),
        ),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorString.white,
          ),
        ),
        Text(
          'uploading...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorString.white,
          )
        )
      ]
    );
  }

  // LOADING INDICATOR
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
