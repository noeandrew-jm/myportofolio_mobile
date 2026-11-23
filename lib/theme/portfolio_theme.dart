import 'package:material_ui/material_ui.dart';

/// Palet diambil dari variabel CSS portofolio web agar seluruh halaman seragam.
abstract final class PortfolioColors {
  static const background = Color(0xFF0C0C0C);
  static const surface = Color(0xFF141416);
  static const ink = Color(0xFFD7E2EA);
  static const muted = Color(0xFFA0A2AD);
  static const accent = Color(0xFFBC6DF0);
  static const line = Color(0xFF2A2A30);
}

final portfolioTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Kanit',
  scaffoldBackgroundColor: PortfolioColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: PortfolioColors.accent,
    brightness: Brightness.dark,
    primary: PortfolioColors.accent,
    surface: PortfolioColors.surface,
    onSurface: PortfolioColors.ink,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: PortfolioColors.background,
    foregroundColor: PortfolioColors.ink,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationThemeData(
    border: OutlineInputBorder(),
    errorMaxLines: 3,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF32203E),
    contentTextStyle: TextStyle(fontFamily: 'Kanit', color: Colors.white),
    behavior: SnackBarBehavior.floating,
  ),
);
