import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

final appSettingProvider = ChangeNotifierProvider<AppSettingNotifier>((ref) {
  return AppSettingNotifier(ref);
});

class AppSettingNotifier extends ChangeNotifier {
  AppSettingNotifier(Ref ref) {
    _pref = ref.watch(sharedPreferencesProvider);
    _isDeleteConfirm = _pref.getBool('isDeleteConfirm') ?? false;
  }

  late final SharedPreferences _pref;

  late bool _isDeleteConfirm;
  bool get isDeleteConfirm => _isDeleteConfirm;

  void toggleDeleteConfirm() {
    _isDeleteConfirm = !_isDeleteConfirm;
    _pref.setBool('isDeleteConfirm', _isDeleteConfirm);
    notifyListeners();
  }
}
