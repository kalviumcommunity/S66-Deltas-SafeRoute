import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class Responsive {
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 700;

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1100) return 900;
    if (width >= 700) return 640;
    return width;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = math.min(width * 0.06, 28.0);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: 18);
  }
}
