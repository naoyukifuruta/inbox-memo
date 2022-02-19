import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/memo_observer.dart';
import 'models/theme_selector.dart';
import 'pages/memo_page.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const flavor = String.fromEnvironment('FLAVOR');
    final themeSelector = ref.watch(themeSelectorProvider.notifier);
    final currentThemeMode = ref.watch(themeSelectorProvider);
    final memo = ref.read(memoProvider);
    return MaterialApp(
      theme: themeSelector.getLightThemeData(),
      darkTheme: themeSelector.getDarkThemeData(),
      themeMode: currentThemeMode,
      debugShowCheckedModeBanner: flavor == 'prd' ? false : true,
      home: MemoPage(initText: memo),
    );
  }
}
