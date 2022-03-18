import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'providers/flavor_provoder.dart';
import 'providers/package_info_provider.dart';
import 'providers/shared_preferences_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final SharedPreferences sp;
  late final PackageInfo pi;
  await Future.wait([
    Future(() async => sp = await SharedPreferences.getInstance()),
    Future(() async => pi = await PackageInfo.fromPlatform()),
  ]);

  const flavor = String.fromEnvironment('FLAVOR');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sp),
            packageInfoProvider.overrideWithValue(pi),
            flavorProvider.overrideWithValue(Flavor.values.byName(flavor)),
          ],
          child: const App(),
        ),
      );
    },
  );
}
