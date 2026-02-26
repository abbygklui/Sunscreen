import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Text styles for the Sunscreen app.
/// Uses Figtree font family (loaded via google_fonts).
class AppTextStyles {
  AppTextStyles._();

  static final TextStyle display = GoogleFonts.figtree(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.darkCocoa,
  );

  static final TextStyle headline = GoogleFonts.figtree(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.darkCocoa,
  );

  static final TextStyle title = GoogleFonts.figtree(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkCocoa,
  );

  static final TextStyle bodyLarge = GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.warmGray,
  );

  static final TextStyle body = GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.warmGray,
  );

  static final TextStyle label = GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.warmGray,
  );
}
