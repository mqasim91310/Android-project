// lib/theme/admin_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminColors {
  static const Color darkBrown   = Color(0xFF3E2723);
  static const Color mediumBrown = Color(0xFF6D4C41);
  static const Color lightBrown  = Color(0xFFBCAAA4);
  static const Color cream       = Color(0xFFF5F0E8);
  static const Color gold        = Color(0xFFD4A017);
  static const Color white       = Color(0xFFFFFFFF);
  static const Color grey        = Color(0xFF9E9E9E);
  static const Color lightGrey   = Color(0xFFF5F5F5);
  static const Color success     = Color(0xFF43A047);
  static const Color error       = Color(0xFFE53935);
  static const Color warning     = Color(0xFFFB8C00);
  static const Color info        = Color(0xFF1E88E5);
  static const Color sidebar     = Color(0xFF2C1A15);
  static const Color cardBg      = Color(0xFFFAF7F2);
}

class AdminTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AdminColors.darkBrown,
        primary: AdminColors.darkBrown,
        secondary: AdminColors.gold,
        surface: AdminColors.cream,
      ),
      scaffoldBackgroundColor: AdminColors.lightGrey,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AdminColors.white,
        elevation: 0,
        shadowColor: AdminColors.lightBrown.withOpacity(0.3),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AdminColors.darkBrown,
        ),
        iconTheme: const IconThemeData(color: AdminColors.darkBrown),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AdminColors.darkBrown,
          foregroundColor: AdminColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AdminColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AdminColors.lightBrown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AdminColors.lightBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AdminColors.darkBrown, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      cardTheme: CardThemeData(
        color: AdminColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AdminColors.lightBrown.withOpacity(0.3)),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStatePropertyAll(AdminColors.cream),
        headingTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: AdminColors.darkBrown,
          fontSize: 13,
        ),
        dataTextStyle: GoogleFonts.poppins(
          color: AdminColors.mediumBrown,
          fontSize: 13,
        ),
      ),
    );
  }
}
