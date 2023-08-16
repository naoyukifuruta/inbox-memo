import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inbox_memo/common/my_theme_data.dart';

import 'pages/top_page.dart';
import 'providers/flavor_provoder.dart';
import 'providers/theme_provider.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: myLightThemeData,
      darkTheme: myDarkThemeData,
      themeMode: ref.watch(themeProvider),
      debugShowCheckedModeBanner:
          ref.read(flavorProvider) == Flavor.prd ? false : true,
      home: const TopPage(),
    );
  }
}
