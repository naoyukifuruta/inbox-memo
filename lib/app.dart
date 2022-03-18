import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/top_page.dart';
import 'providers/flavor_provoder.dart';
import 'providers/theme_provider.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeProvider.notifier);
    final currentThemeMode = ref.watch(themeProvider);
    final flavor = ref.read(flavorProvider);
    return MaterialApp(
      theme: themeSelector.getLightThemeData(),
      darkTheme: themeSelector.getDarkThemeData(),
      themeMode: currentThemeMode,
      debugShowCheckedModeBanner: flavor == Flavor.prd ? false : true,
      home: const TopPage(),
    );
  }
}
