import 'dart:async';

import 'package:flutter/foundation.dart';

String slugify(String string) {
  return string.replaceAll(RegExp(r"[^a-zA-Z0-9]+"), "-").toLowerCase();
}

class Constants {
  static String gSearchAPI = "AIzaSyARV_EjWYlVg8_GUooSPhuZN_8BF6Hhkf8";
}

class AppDefault {
  static const double xxFontSize = 39.81;
  static const double xFontSize = 33.18;
  static const double mmFontSize = 27.65;
  static const double mFontSize = 23.04;
  static const double ssFontSize = 19.20;
  static const double sFontSize = 16.00;
  static const double xsFontSize = 12.00;
  static const double sizeDown = 2;
  static const String fontFamily = 'GowunDodum';
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
