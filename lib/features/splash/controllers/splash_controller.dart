import 'dart:async';
import 'package:flutter/foundation.dart';

class SplashController {
  Timer? _timer;

  void start({required VoidCallback onFinished}) {
    _timer?.cancel();

    _timer = Timer(const Duration(seconds: 3), onFinished);
  }

  void dispose() {
    _timer?.cancel();
  }
}
