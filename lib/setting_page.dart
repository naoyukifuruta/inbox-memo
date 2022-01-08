import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'models/theme_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Consumer<ThemeModel>(
              builder: (context, model, c) {
                return ListTile(
                  leading: const Icon(FontAwesomeIcons.adjust),
                  title: const Text('ダークモード'),
                  trailing: Switch.adaptive(
                    value: model.isDark,
                    onChanged: (_) {
                      model.changeMode();
                    },
                  ),
                  onTap: null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
