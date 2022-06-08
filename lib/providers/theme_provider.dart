import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/my_app_theme.dart';
import 'shared_preferences_provider.dart';

final themeProvider = StateNotifierProvider<ThemeSelector, MyAppTheme>((ref) {
  return ThemeSelector(ref.read(sharedPreferencesProvider));
});

class ThemeSelector extends StateNotifier<MyAppTheme> {
  ThemeSelector(this._pref) : super(const MyAppTheme()) {
    final isDark = _pref.getBool('isDark') ?? false;
    state = MyAppTheme(isDark: isDark);
  }

  final SharedPreferences _pref;

  void toggleThemeMode() {
    state = state.copyWith(isDark: !state.isDark);
    _pref.setBool('isDark', state.isDark);
  }
}
