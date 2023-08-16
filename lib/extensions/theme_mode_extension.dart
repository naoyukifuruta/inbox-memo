import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  bool get isDark => _isDark();

  bool _isDark() {
    if (this == ThemeMode.dark) {
      return true;
    }
    return false;
  }
}
