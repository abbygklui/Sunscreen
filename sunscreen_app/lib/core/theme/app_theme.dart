import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App-wide Material 3 theme configuration.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.sunshineYellow,
        brightness: Brightness.light,
        surface: AppColors.cloudWhite,
      ),
      scaffoldBackgroundColor: AppColors.cloudWhite,
      fontFamily: 'Nunito',
      cardTheme: CardTheme(
        color: AppColors.cream,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sunshineYellow,
          foregroundColor: AppColors.darkCocoa,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cloudWhite,
        foregroundColor: AppColors.darkCocoa,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.darkCocoa,
        ),
      ),
    );
  }
}
