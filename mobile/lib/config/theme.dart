import 'package:flutter/material.dart';

sealed class AppTheme {
  static const _primaryColor = Color(0xFFBC6C25);

  static final themeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _primaryColor,
    brightness: Brightness.light,
  );

  static final darkThemeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _primaryColor,
    brightness: Brightness.dark,
  );
}
