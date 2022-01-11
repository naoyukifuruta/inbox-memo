import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'models/memo_model.dart';
import 'models/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      child: const App(),
    ),
  );
}
