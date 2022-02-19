import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

final themeProvider = StateNotifierProvider<ThemeSelector, ThemeMode>((ref) {
  return ThemeSelector(ref);
});

class ThemeSelector extends StateNotifier<ThemeMode> {
  ThemeSelector(this._ref) : super(ThemeMode.light) {
    _pref = _ref.read(sharedPreferencesProvider);
    _isDark = _pref.getBool('isDark') ?? false;
    state = _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  final Ref _ref;
  late final SharedPreferences _pref;

  bool get isDark => _isDark;
  bool _isDark = false;

  ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blueGrey,
    );
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void toggleThemeMode() {
    _isDark = !_isDark;
    _pref.setBool('isDark', _isDark);
    state = _isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
