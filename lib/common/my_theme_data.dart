import 'package:flutter/material.dart';

final myLightThemeData = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.blueGrey,
);

final myDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.blueGrey[300],
  hintColor: Colors.blueGrey[300],
);
