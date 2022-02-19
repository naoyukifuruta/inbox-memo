import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

final appSettingProvider = ChangeNotifierProvider<AppSettingNotifier>((ref) {
  return AppSettingNotifier(ref);
});

class AppSettingNotifier extends ChangeNotifier {
  AppSettingNotifier(this._ref) {
    _pref = _ref.watch(sharedPreferencesProvider);
  }

  final Ref _ref;
  late final SharedPreferences _pref;

  final String _prefKeyDeleteConfirm = 'isDeleteConfirm';

  bool getDeleteConfirm() {
    return _pref.getBool(_prefKeyDeleteConfirm) ?? false;
  }

  void toggleDeleteConfirmMode() {
    var setValue = !getDeleteConfirm();
    _pref.setBool(_prefKeyDeleteConfirm, setValue);
    notifyListeners();
  }
}
