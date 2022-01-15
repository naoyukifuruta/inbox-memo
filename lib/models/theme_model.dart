import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  late SharedPreferences _pref;

  bool get isDark => _isDark;
  bool _isDark = false;

  ThemeModel(SharedPreferences pref) {
    _pref = pref;
    _isDark = pref.getBool('isDark') ?? false;
  }

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

  void changeMode() async {
    _isDark = !_isDark;
    _pref.setBool('isDark', _isDark);
    notifyListeners();
  }
}
