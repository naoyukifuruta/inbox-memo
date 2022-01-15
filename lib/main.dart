import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inbox_memo/models/app_info_model.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'models/memo_model.dart';
import 'models/theme_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final SharedPreferences sp;
  late final PackageInfo pi;
  await Future.wait([
    Future(() async => sp = await SharedPreferences.getInstance()),
    Future(() async => pi = await PackageInfo.fromPlatform()),
  ]);

  final themeModel = ThemeModel(sp);
  final memoModel = MemoModel(sp);
  final appInfoModel = AppInfoModel(pi);

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
          ChangeNotifierProvider<AppInfoModel>(
            create: (context) => appInfoModel,
          ),
        ],
        child: const App(),
      ),
    );
  });
}
