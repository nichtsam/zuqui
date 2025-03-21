import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xFFBC6C25);

  static final themeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor, brightness: Brightness.light),
  );
}
