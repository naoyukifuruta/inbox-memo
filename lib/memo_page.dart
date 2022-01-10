import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'models/memo_model.dart';
import 'models/theme_model.dart';

class MemoPage extends StatelessWidget {
  MemoPage({Key? key, required this.initText}) : super(key: key) {
    controller = TextEditingController(text: initText);
  }

  String initText;
  late TextEditingController controller;
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    final int textMaxLines = MediaQuery.of(context).size.height ~/ 100 * 2;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.blueGrey[50],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
              ),
            ),
            cursorColor: Colors.blueGrey,
            controller: controller,
            maxLines: textMaxLines,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
            autofocus: true,
            focusNode: _focusNode,
            onChanged: (text) {
              context.read<MemoModel>().save(text);
            },
            // onTap: () {
            //   _focusNode.requestFocus();
            // },
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 32), // 左にめり込むのでその対策
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.cog),
              onPressed: () async {
                if (_focusNode.hasFocus) {
                  _focusNode.unfocus();
                } else {
                  FocusScope.of(context).unfocus();
                }

                await showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return const SettingModalSheet();
                  },
                );
                _focusNode.requestFocus();
              },
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.shareAlt),
              onPressed: () async {
                if (controller.text == '') {
                  debugPrint('text empty.');
                  return;
                }
                _focusNode.unfocus();
                await Share.share(controller.text);
              },
            ),
            const Expanded(child: SizedBox()),
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.trash),
              backgroundColor: Colors.red[300],
              onPressed: () {
                if (controller.text == '') {
                  debugPrint('text empty.');
                  _focusNode.requestFocus();
                  return;
                }
                context.read<MemoModel>().clear();
                controller.clear();

                // TODO: このルート通ったときにキーボードがきえない問題（iOS/Android両方）
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingModalSheet extends StatelessWidget {
  const SettingModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
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
                  child: Icon(FontAwesomeIcons.adjust),
                ),
                title: const Text('ダークモード'),
                subtitle:
                    Text(context.read<ThemeModel>().isDark ? 'ON' : 'OFF'),
                trailing: Switch.adaptive(
                  value: context.read<ThemeModel>().isDark,
                  onChanged: (_) {
                    context.read<ThemeModel>().changeMode();
                  },
                ),
                onTap: null,
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
