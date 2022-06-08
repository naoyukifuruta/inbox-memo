import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

import '../providers/app_setting_provider.dart';
import '../providers/theme_provider.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 360,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            // 上部の−
            Container(
              height: 5,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).backgroundColor,
              ),
            ),
            // タイトル
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                '設定',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // 削除確認
            const _DeleteConfirmElement(),
            // ダークモード
            const _DarkModeElement(),
            // アプリについて
            const _AppInfomationElement(),
            // キャンセルボタン
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text('キャンセル'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteConfirmElement extends HookConsumerWidget {
  const _DeleteConfirmElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSetting = ref.watch(appSettingProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        leading: const SizedBox(
          height: 40,
          child: Icon(Icons.electric_bolt),
        ),
        title: const Text('削除時に確認を行う'),
        subtitle: Text(appSetting.isDeleteConfirm ? 'ON' : 'OFF'),
        trailing: Switch.adaptive(
          value: appSetting.isDeleteConfirm,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (_) {
            ref.read(appSettingProvider.notifier).toggleDeleteConfirm();
          },
        ),
        onTap: null,
      ),
    );
  }
}

class _DarkModeElement extends HookConsumerWidget {
  const _DarkModeElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        leading: const SizedBox(
          height: 40,
          child: Icon(Icons.dark_mode_outlined),
        ),
        title: const Text('ダークモード'),
        subtitle: Text(theme.isDark ? 'ON' : 'OFF'),
        trailing: Switch.adaptive(
          value: theme.isDark,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (_) {
            ref.read(themeProvider.notifier).toggleThemeMode();
          },
        ),
        onTap: null,
      ),
    );
  }
}

class _AppInfomationElement extends HookConsumerWidget {
  const _AppInfomationElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        leading: const SizedBox(
          height: 40,
          child: Icon(Icons.info_outline),
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
    );
  }
}
