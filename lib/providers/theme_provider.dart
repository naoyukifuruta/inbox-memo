import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'shared_preferences_provider.dart';

const _themePrefsKey = 'selectedThemeKey';

final themeProvider = StateNotifierProvider<ThemeSelector, ThemeMode>(
  (ref) {
    return ThemeSelector(ref);
  },
);

class ThemeSelector extends StateNotifier<ThemeMode> {
  ThemeSelector(this._ref) : super(ThemeMode.system) {
    final themeIndex = _prefs.getInt(_themePrefsKey);
    if (themeIndex == null) {
      return;
    }
    final themeMode = ThemeMode.values.firstWhere(
      (e) => e.index == themeIndex,
      orElse: () => ThemeMode.system,
    );
    state = themeMode;
  }

  final Ref _ref;
  late final _prefs = _ref.read(sharedPreferencesProvider);

  Future<void> toggleThemeMode() async {
    final theme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await changeAndSave(theme);
  }

  Future<void> changeAndSave(ThemeMode theme) async {
    await _prefs.setInt(_themePrefsKey, theme.index);
    state = theme;
  }
}
