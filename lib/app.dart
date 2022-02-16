import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'memo_page.dart';
import 'models/memo_model.dart';
import 'models/theme_model.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const flavor = String.fromEnvironment('FLAVOR');
    return Consumer<ThemeModel>(
      builder: (context, theme, child) {
        return MaterialApp(
          theme: theme.getLightThemeData(),
          darkTheme: theme.getDarkThemeData(),
          themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: flavor == 'prd' ? false : true,
          home: Consumer<MemoModel>(
            builder: (context, memo, child) {
              return MemoPage(initText: memo.load());
            },
          ),
        );
      },
    );
  }
}
