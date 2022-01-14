import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'models/memo_model.dart';
import 'models/theme_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final SharedPreferences sp;
  await Future.wait([
    Future(() async => sp = await SharedPreferences.getInstance()),
  ]);

  final themeModel = ThemeModel(sp);
  final memoModel = MemoModel(sp);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
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
  });
}
