import 'package:flutter/material.dart';

class GrayscaleChecker {
  static bool isDarkColor(Color color) {
    final grayscale =
        (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);

    if (grayscale > 128) return false;
    return true;
  }
}
