import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/top_page.dart';
import 'providers/flavor_provoder.dart';
import 'providers/theme_provider.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ref.watch(themeProvider.notifier).getLightThemeData(),
      darkTheme: ref.watch(themeProvider.notifier).getDarkThemeData(),
      themeMode: ref.watch(themeProvider),
      debugShowCheckedModeBanner:
          ref.read(flavorProvider) == Flavor.prd ? false : true,
      home: const TopPage(),
    );
  }
}
