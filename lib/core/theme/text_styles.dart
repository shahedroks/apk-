import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle brandTitle({double fontSize = 18}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: -0.45,
        height: 24 / 18,
      );

  static TextStyle screenTitle({double fontSize = 22}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.55,
        height: 28 / 22,
      );

  static TextStyle subtitle({double fontSize = 14}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: -0.35,
        height: 20 / 14,
      );

  static TextStyle label({double fontSize = 13}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.33,
        height: 18 / 13,
      );

  static TextStyle caption({double fontSize = 12}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        height: 16 / 12,
      );

  static TextStyle overline({double fontSize = 10}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 1,
        height: 12 / 10,
      );

  static TextStyle button({double fontSize = 15}) => _base(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: -0.38,
        height: 20 / 15,
      );

  static TextTheme get textTheme {
    return TextTheme(
      headlineLarge: screenTitle(fontSize: 28),
      titleLarge: screenTitle(),
      bodyLarge: subtitle(fontSize: 16),
      bodyMedium: subtitle(),
      labelLarge: button(),
    );
  }
}
