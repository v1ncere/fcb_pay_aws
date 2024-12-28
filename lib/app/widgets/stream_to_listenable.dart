import 'dart:async';

import 'package:flutter/material.dart';

class StreamToListenable extends ChangeNotifier {
  StreamToListenable(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}