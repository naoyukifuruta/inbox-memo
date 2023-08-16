import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_setting.dart';
import 'shared_preferences_provider.dart';

const _deleteConfirmPrefsKey = 'isDeleteConfirm';

final appSettingProvider =
    StateNotifierProvider<AppSettingNotifier, AppSetting>(
  (ref) {
    return AppSettingNotifier(ref);
  },
);

class AppSettingNotifier extends StateNotifier<AppSetting> {
  AppSettingNotifier(this._ref) : super(const AppSetting()) {
    final isDeleteConfirm = _prefs.getBool(_deleteConfirmPrefsKey) ?? false;
    state = AppSetting(isDeleteConfirm: isDeleteConfirm);
  }

  final Ref _ref;
  late final _prefs = _ref.read(sharedPreferencesProvider);

  void toggleDeleteConfirm() {
    state = state.copyWith(isDeleteConfirm: !state.isDeleteConfirm);
    _prefs.setBool(_deleteConfirmPrefsKey, state.isDeleteConfirm);
  }
}
