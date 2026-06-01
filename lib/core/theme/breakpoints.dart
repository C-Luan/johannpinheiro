import 'package:flutter/widgets.dart';

abstract class Breakpoints {
  static const double mobile  = 600;
  static const double tablet  = 1024;

  static bool isMobile(BuildContext ctx)  => MediaQuery.sizeOf(ctx).width < mobile;
  static bool isTablet(BuildContext ctx)  => MediaQuery.sizeOf(ctx).width >= mobile && MediaQuery.sizeOf(ctx).width < tablet;
  static bool isDesktop(BuildContext ctx) => MediaQuery.sizeOf(ctx).width >= tablet;

  static double displaySize(BuildContext ctx) {
    final w = MediaQuery.sizeOf(ctx).width;
    if (w < mobile) return 40;
    if (w < tablet) return 56;
    return 72;
  }
}
