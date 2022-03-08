import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

import '../providers/app_setting_provider.dart';
import '../providers/theme_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeProvider.notifier);
    final appSetting = ref.watch(appSettingProvider);
    return Container(
      height: 360,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 5,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).backgroundColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                '設定',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                leading: const SizedBox(
                  height: 40,
                  child: Icon(FontAwesomeIcons.exclamationTriangle),
                ),
                title: const Text('削除時に確認を行う'),
                subtitle: Text(appSetting.isDeleteConfirm ? 'ON' : 'OFF'),
                trailing: Switch.adaptive(
                  value: appSetting.isDeleteConfirm,
                  onChanged: (_) {
                    appSetting.toggleDeleteConfirm();
                  },
                ),
                onTap: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                leading: const SizedBox(
                  height: 40,
                  child: Icon(FontAwesomeIcons.adjust),
                ),
                title: const Text('ダークモード'),
                subtitle: Text(themeSelector.isDark ? 'ON' : 'OFF'),
                trailing: Switch.adaptive(
                  value: themeSelector.isDark,
                  onChanged: (_) {
                    themeSelector.toggleThemeMode();
                  },
                ),
                onTap: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                leading: const SizedBox(
                  height: 40,
                  child: Icon(FontAwesomeIcons.infoCircle),
                ),
                title: const Text('アプリについて'),
                onTap: () async {
                  final info = await PackageInfo.fromPlatform();
                  showAboutDialog(
                    context: context,
                    applicationName: info.appName,
                    applicationVersion: info.version,
                    applicationLegalese: "2022 ©Naoyuki Furuta",
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
