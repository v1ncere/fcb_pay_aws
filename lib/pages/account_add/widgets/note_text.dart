import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

Text noteText() {
  return const Text(
    TextString.registrationNote,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.teal,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      shadows: <Shadow>[
        Shadow(
          color: Colors.black87, // Shadow color
          blurRadius: 1,
          offset: Offset(0, 1)
        )
      ]
    )
  );
}