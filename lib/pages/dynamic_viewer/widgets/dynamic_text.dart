import 'package:flutter/material.dart';

import '../../../models/ModelProvider.dart';
import '../../../widgets/widgets.dart';

class DynamicText extends StatelessWidget {
  const DynamicText({
    super.key,
    required this.widget
  });
  final DynamicWidget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
      child: CustomText(
        text: widget.title!,
        color: Colors.black54,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}