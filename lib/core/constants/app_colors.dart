import 'package:flutter/material.dart';

/// SWAP IT design tokens from `doc/auto.md`.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFF8F9FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF0D3B2E);
  static const Color primaryDark = Color(0xFF00241A);
  static const Color accentLime = Color(0xFFACF847);
  static const Color accentGreen = Color(0xFF416900);
  static const Color textPrimary = Color(0xFF121C2A);
  static const Color textSecondary = Color(0xFF414845);
  static const Color textMuted = Color(0xFF717974);
  static const Color borderLight = Color(0xFFE6EEFF);
  static const Color infoBackground = Color(0xFFEFF4FF);
  static const Color infoBorder = Color(0xFFD9E3F6);
  static const Color mintGlow = Color(0xFFBEEDD9);
  static const Color toggleTrack = Color(0xFFE6EEFF);
  static const Color error = Color(0xFFB3261E);

  // Legacy aliases used elsewhere
  static const Color secondary = textSecondary;
  static const Color onSurface = textPrimary;
}
