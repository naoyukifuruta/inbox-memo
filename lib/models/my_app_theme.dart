import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_app_theme.freezed.dart';

@freezed
class MyAppTheme with _$MyAppTheme {
  const MyAppTheme._();
  const factory MyAppTheme({
    @Default(false) bool isDark,
  }) = _MyAppTheme;

  ThemeMode getThemeMode() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blueGrey,
      primaryColor: Colors.blueGrey,
    );
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blueGrey,
      primaryColor: Colors.blueGrey[300],
      hintColor: Colors.blueGrey[300],
    );
  }
}
