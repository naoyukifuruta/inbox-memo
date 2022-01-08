import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  ThemeModel(SharedPreferences pref) {
    _init(pref);
  }

  bool get isDark => _isDark;
  bool _isDark = false;

  void _init(SharedPreferences pref) async {
    _isDark = pref.getBool('isDark') ?? false;
  }

  ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blueGrey,
      accentColor: Colors.blueGrey, // TODO: deprecated
      dividerColor: Colors.black,
    );
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.pink,
      accentColor: Colors.pink, // TODO: deprecated
      dividerColor: Colors.white,
    );
  }

  void changeMode() async {
    _isDark = !_isDark;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', _isDark);
    notifyListeners();
  }
}
