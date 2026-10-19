import 'package:flutter/material.dart';

/// SWAP IT design tokens (buyer-approved palette).
class AppColors {
  AppColors._();

  // —— Brand palette ——
  /// Warm Ivory — screen background.
  static const Color warmIvory = Color(0xFFF8F4EC);

  /// Green-Tinted Gray — text fields, inputs, subtle fills.
  static const Color fieldGray = Color(0xFFE7EAE1);

  /// Light Sage Green — cards and elevated surfaces.
  static const Color sageCard = Color(0xFFD8E4D8);

  /// Forest Green — primary buttons, headings, key UI.
  static const Color forestGreen = Color(0xFF154835);

  /// Medium Green — badges, success chips, eco accents.
  static const Color mediumGreen = Color(0xFF256249);

  /// Earthy Gold — highlights, toggles, premium accents.
  static const Color earthyGold = Color(0xFFBD842D);

  /// Warm Terracotta — text links, secondary badges.
  static const Color warmTerracotta = Color(0xFFCC844C);

  // —— Surfaces ——
  static const Color background = warmIvory;
  static const Color surface = sageCard;

  // —— Primary ——
  static const Color primary = forestGreen;
  static const Color primaryDark = Color(0xFF103828);

  // —— Accents (legacy names kept for existing widgets) ——
  static const Color accentLime = earthyGold;
  static const Color accentGreen = mediumGreen;
  static const Color link = warmTerracotta;
  static const Color badge = mediumGreen;

  // —— Text ——
  static const Color textPrimary = Color(0xFF1A2E26);
  static const Color textSecondary = Color(0xFF3D4A42);
  static const Color textMuted = Color(0xFF6B7569);

  // —— Fields & borders ——
  static const Color borderLight = fieldGray;
  static const Color infoBackground = fieldGray;
  static const Color infoBorder = Color(0xFFD5D9CE);
  static const Color mintGlow = sageCard;
  static const Color toggleTrack = fieldGray;

  static const Color error = Color(0xFFB3261E);

  // Legacy aliases
  static const Color secondary = textSecondary;
  static const Color onSurface = textPrimary;
}
