import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Global theme-mode notifier — imported by both main.dart and profile_screen.dart
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.panel,
    required this.accent,
    required this.accentDark,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
  });

  final Color background;
  final Color surface;
  final Color panel;
  final Color accent;
  final Color accentDark;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  // ── Dark palette ──────────────────────────────────────────────────────────
  static const AppColors dark = AppColors(
    background:    Color(0xFF07080F),
    surface:       Color(0xFF0F1623),
    panel:         Color(0xFF151E30),
    accent:        Color(0xFFFF5400),
    accentDark:    Color(0xFFCC4300),
    textPrimary:   Color(0xFFF5F6FF),
    textSecondary: Color(0xFF8292AE),
    textMuted:     Color(0xFF4E5E78),
    border:        Color(0xFF1E2D42),
  );

  // ── Light palette ─────────────────────────────────────────────────────────
  static const AppColors light = AppColors(
    background:    Color(0xFFF5F6FA),
    surface:       Color(0xFFFFFFFF),
    panel:         Color(0xFFEDEEF3),
    accent:        Color(0xFFFF5400),
    accentDark:    Color(0xFFCC4300),
    textPrimary:   Color(0xFF0D111A),
    textSecondary: Color(0xFF5C6478),
    textMuted:     Color(0xFF9AA3B8),
    border:        Color(0xFFDDE1EA),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? panel,
    Color? accent,
    Color? accentDark,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
  }) =>
      AppColors(
        background:    background    ?? this.background,
        surface:       surface       ?? this.surface,
        panel:         panel         ?? this.panel,
        accent:        accent        ?? this.accent,
        accentDark:    accentDark    ?? this.accentDark,
        textPrimary:   textPrimary   ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textMuted:     textMuted     ?? this.textMuted,
        border:        border        ?? this.border,
      );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      background:    Color.lerp(background,    other.background,    t)!,
      surface:       Color.lerp(surface,       other.surface,       t)!,
      panel:         Color.lerp(panel,         other.panel,         t)!,
      accent:        Color.lerp(accent,        other.accent,        t)!,
      accentDark:    Color.lerp(accentDark,    other.accentDark,    t)!,
      textPrimary:   Color.lerp(textPrimary,   other.textPrimary,   t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted:     Color.lerp(textMuted,     other.textMuted,     t)!,
      border:        Color.lerp(border,        other.border,        t)!,
    );
  }
}

class AppTheme {
  static ThemeData get dark  => _build(AppColors.dark,  Brightness.dark);
  static ThemeData get light => _build(AppColors.light, Brightness.light);

  static ThemeData _build(AppColors c, Brightness brightness) {
    final scheme = ColorScheme(
      brightness:  brightness,
      primary:     c.accent,
      onPrimary:   Colors.white,
      secondary:   c.accent,
      onSecondary: Colors.white,
      error:       const Color(0xFFFF5252),
      onError:     Colors.white,
      surface:     c.surface,
      onSurface:   c.textPrimary,
    );

    return ThemeData(
      brightness:              brightness,
      useMaterial3:            true,
      scaffoldBackgroundColor: c.background,
      primaryColor:            c.accent,
      colorScheme:             scheme,
      canvasColor:             c.surface,
      cardColor:               c.panel,
      hintColor:               c.textMuted,
      dividerColor:            c.border,
      extensions:              [c],

      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:          Colors.transparent,
          statusBarIconBrightness: brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
        ),
      ),

      textTheme: TextTheme(
        bodyLarge:   TextStyle(color: c.textPrimary,   fontSize: 16),
        bodyMedium:  TextStyle(color: c.textSecondary, fontSize: 14),
        bodySmall:   TextStyle(color: c.textMuted,     fontSize: 12),
        titleLarge:  TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w600),
        labelLarge:  TextStyle(color: c.textPrimary,   fontWeight: FontWeight.w600),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled:         true,
        fillColor:      c.surface,
        hintStyle:      TextStyle(color: c.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:   BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:   BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:   BorderSide(color: c.accent, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: Colors.white,
          elevation:       0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding:   const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.accent,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.accent,
          side:  BorderSide(color: c.accent),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        ),
      ),

      cardTheme: CardThemeData(
        color:     c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side:         BorderSide(color: c.border, width: 0.5),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor:     c.surface,
        selectedColor:       c.accent,
        labelStyle:          TextStyle(color: c.textSecondary, fontSize: 13),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side:         BorderSide(color: c.border, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor:  c.panel,
        contentTextStyle: TextStyle(color: c.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        behavior: SnackBarBehavior.floating,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFFF5400),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
    );
  }
}
