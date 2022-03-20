import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_setting.dart';
import 'shared_preferences_provider.dart';

final appSettingProvider =
    StateNotifierProvider<AppSettingNotifier, AppSetting>((ref) {
  return AppSettingNotifier(ref.read(sharedPreferencesProvider));
});

class AppSettingNotifier extends StateNotifier<AppSetting> {
  AppSettingNotifier(this._pref) : super(const AppSetting()) {
    final isDeleteConfirm = _pref.getBool('isDeleteConfirm') ?? false;
    state = AppSetting(isDeleteConfirm: isDeleteConfirm);
  }

  late final SharedPreferences _pref;

  void toggleDeleteConfirm() {
    state = state.copyWith(isDeleteConfirm: !state.isDeleteConfirm);
    _pref.setBool('isDeleteConfirm', state.isDeleteConfirm);
  }
}
