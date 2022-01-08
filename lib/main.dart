import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'memo_page.dart';
import 'models/memo_model.dart';
import 'models/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final pref = await SharedPreferences.getInstance();
  final themeModel = ThemeModel(pref);
  final memoModel = MemoModel(pref);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(
          create: (context) => themeModel,
        ),
        ChangeNotifierProvider<MemoModel>(
          create: (context) => memoModel,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, model, child) {
      return MaterialApp(
        theme: model.getLightThemeData(),
        darkTheme: model.getDarkThemeData(),
        themeMode: model.isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: MemoPage(),
      );
    });
  }
}
