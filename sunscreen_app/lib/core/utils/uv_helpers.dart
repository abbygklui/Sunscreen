import '../theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Helper functions for UV index display.
class UvHelpers {
  UvHelpers._();

  /// Returns a human-readable label for a UV index value.
  static String uvLabel(double uvIndex) {
    if (uvIndex < 3) return 'Low';
    if (uvIndex < 6) return 'Moderate';
    if (uvIndex < 8) return 'High';
    if (uvIndex < 11) return 'Very High';
    return 'Extreme';
  }

  /// Returns a friendly message based on UV level.
  static String uvMessage(double uvIndex) {
    if (uvIndex < 3) {
      return 'Low UV today — enjoy the outdoors!';
    }
    if (uvIndex < 6) {
      return 'Moderate UV today. Sunscreen is a good idea!';
    }
    if (uvIndex < 8) {
      return "It's a sunny one today! Don't forget your sunscreen!";
    }
    if (uvIndex < 11) {
      return 'Very high UV — definitely wear sunscreen and a hat!';
    }
    return 'Extreme UV! Stay protected and seek shade when possible.';
  }

  /// Returns the color for a UV index value.
  static Color uvColor(double uvIndex) => AppColors.uvColor(uvIndex);
}
