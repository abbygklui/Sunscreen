import 'package:flutter/material.dart';

/// Sunscreen app color palette.
/// See STYLE_GUIDE.md for full details.
class AppColors {
  AppColors._();

  // Primary
  static const Color sunshineYellow = Color(0xFFFFD54F);
  static const Color warmOrange = Color(0xFFFFB74D);
  static const Color softCoral = Color(0xFFFF8A80);

  // Neutrals
  static const Color cloudWhite = Color(0xFFFFF8E1);
  static const Color cream = Color(0xFFFFECB3);
  static const Color warmGray = Color(0xFF8D6E63);
  static const Color darkCocoa = Color(0xFF4E342E);

  // UV Levels
  static const Color uvLow = Color(0xFFA5D6A7);
  static const Color uvModerate = Color(0xFFFFD54F);
  static const Color uvHigh = Color(0xFFFFB74D);
  static const Color uvVeryHigh = Color(0xFFFF8A80);
  static const Color uvExtreme = Color(0xFFE57373);

  // Timer
  static const Color timerActive = Color(0xFFFFB74D);
  static const Color timerComplete = Color(0xFFA5D6A7);

  /// Returns the appropriate color for a given UV index value.
  static Color uvColor(double uvIndex) {
    if (uvIndex < 3) return uvLow;
    if (uvIndex < 6) return uvModerate;
    if (uvIndex < 8) return uvHigh;
    if (uvIndex < 11) return uvVeryHigh;
    return uvExtreme;
  }
}
