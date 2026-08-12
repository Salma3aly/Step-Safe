import 'package:flutter/material.dart';

/// Central place for colors and theming so the whole app stays consistent.
/// Teal reads as "trust / safety", coral/red is reserved for risk states.
class AppColors {
  static const Color primary = Color(0xFF0F6E56);
  static const Color primaryLight = Color(0xFFE1F5EE);
  static const Color danger = Color(0xFF993C1D);
  static const Color dangerLight = Color(0xFFFAECE7);
  static const Color warning = Color(0xFF854F0B);
  static const Color warningLight = Color(0xFFFAEEDA);
  static const Color surface = Color(0xFFF7F8F6);
  static const Color textPrimary = Color(0xFF1B1D1B);
  static const Color textSecondary = Color(0xFF5F6660);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.surface,
    );
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE7E9E6)),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryLight,
        elevation: 0,
      ),
    );
  }
}
