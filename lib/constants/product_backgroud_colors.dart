import 'dart:math';

import 'package:flutter/material.dart';

class ProductCardBackgroundColors {
  Color randomColorGenerator() {
    final Random random = Random();
    final List<Color> colors = [
      const Color(0xFFC8E6C9), // light green
      const Color(0xFFFFF9C4), // pale yellow
      const Color(0xFFFFE0B2), //light peach
      const Color(0xFFFFCDD2), //soft pink
      const Color(0xFFE1BEE7), // lilac
      const Color(0xFFB2EBF2), //light aqua
    ];
    return colors[random.nextInt(colors.length)];
  }
}
