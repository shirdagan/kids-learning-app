import 'package:flutter/material.dart';

/// עיצוב כללי לאפליקציה: צבעים חמים, כפתורים גדולים וגופנים ברורים,
/// מתאים למגע של ילדים קטנים.
class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFFFFFBF0);
  static const Color primary = Color(0xFFFF7A59);
  static const Color secondary = Color(0xFF4FB6E8);
  static const Color success = Color(0xFF57C468);

  /// גודל מגע מינימלי מומלץ עבור ילדים קטנים (גדול משמעותית מהמינימום
  /// הרגיל של 48 לוגי-פיקסלים למבוגרים).
  static const double minTouchTarget = 96;

  static ThemeData get themeData {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,
      fontFamily: 'Rubik',
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontSizeFactor: 1.0,
        bodyColor: const Color(0xFF3A2E2E),
        displayColor: const Color(0xFF3A2E2E),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 6,
        ),
      ),
    );
  }
}
