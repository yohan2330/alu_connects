import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF08131F);
  static const surface = Color(0xFF0F2944);
  static const panel = Color(0xFF112B44);
  static const accent = Color(0xFFF2B237);
  static const accentDark = Color(0xFFD89A1A);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9BB0D4);
  static const textMuted = Color(0xFF718099);
  static const border = Color(0xFF28435B);
}

class AppTheme {
  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: Colors.black,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accent,
      colorScheme: colorScheme.copyWith(
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      canvasColor: AppColors.surface,
      cardColor: AppColors.panel,
      hintColor: AppColors.textMuted,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
        titleLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
