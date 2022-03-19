import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';
import 'shared_preferences_provider.dart';

final appSettingProvider =
    StateNotifierProvider<AppSettingNotifier, AppSettings>((ref) {
  return AppSettingNotifier(ref.read(sharedPreferencesProvider));
});

class AppSettingNotifier extends StateNotifier<AppSettings> {
  AppSettingNotifier(this._pref) : super(AppSettings.init()) {
    final isDeleteConfirm = _pref.getBool('isDeleteConfirm') ?? false;
    state = AppSettings(isDeleteConfirm);
  }

  late final SharedPreferences _pref;

  void toggleDeleteConfirm() {
    state = state.copyWith(isDeleteConfirm: !state.isDeleteConfirm);
    _pref.setBool('isDeleteConfirm', state.isDeleteConfirm);
  }
}
