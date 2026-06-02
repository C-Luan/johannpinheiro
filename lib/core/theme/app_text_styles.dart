import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

const _satoshi = 'Satoshi';

abstract class AppTextStyles {
  static TextStyle display({double size = 72, FontWeight weight = FontWeight.w300, Color color = AppColors.textPrimary}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: weight, color: color, height: 1.1, letterSpacing: -1.0);

  static TextStyle displayGold({double size = 72, FontWeight weight = FontWeight.w700}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: weight, color: AppColors.gold, height: 1.1, letterSpacing: -1.0);

  static TextStyle eyebrow({double size = 12}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w500, color: AppColors.gold,
          letterSpacing: 3.0, height: 1.0);

  static TextStyle nav({double size = 14, Color color = AppColors.textPrimary}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w400, color: color,
          letterSpacing: 1.5);

  static TextStyle navActive({double size = 14}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w400, color: AppColors.gold,
          letterSpacing: 1.5);

  static TextStyle logo({double size = 20, Color color = AppColors.textPrimary}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w700, color: color,
          letterSpacing: 0.5);

  static TextStyle body({double size = 16, Color color = AppColors.textMuted}) =>
      GoogleFonts.inter(fontSize: size, fontWeight: FontWeight.w400, color: color, height: 1.7);

  static TextStyle bodyBold({double size = 16, Color color = AppColors.textPrimary}) =>
      GoogleFonts.inter(fontSize: size, fontWeight: FontWeight.w600, color: color, height: 1.6);

  static TextStyle quote({double size = 18}) =>
      GoogleFonts.inter(fontSize: size, fontStyle: FontStyle.italic, color: AppColors.gold, height: 1.6);

  static TextStyle serviceNumber({double size = 48}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w300, color: AppColors.gold, height: 1.0);

  static TextStyle cardTitle({double size = 18}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.3);

  static TextStyle tag({double size = 11}) =>
      TextStyle(fontFamily: _satoshi, fontSize: size, fontWeight: FontWeight.w500, color: AppColors.gold,
          letterSpacing: 2.0);
}
