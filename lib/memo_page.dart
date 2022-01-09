import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox_memo/setting_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'models/memo_model.dart';

class MemoPage extends StatelessWidget {
  MemoPage({Key? key, required this.initText}) : super(key: key) {
    controller = TextEditingController(text: initText);
  }

  String initText;
  late TextEditingController controller;

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
            onChanged: (text) {
              context.read<MemoModel>().save(text);
            },
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
                // 設定画面へ遷移
                await showBarModalBottomSheet(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) => Navigator(
                    onGenerateRoute: (context) =>
                        MaterialPageRoute<SettingPage>(
                      builder: (context) => const SettingPage(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.shareAlt),
              onPressed: () {
                if (controller.text == '') {
                  debugPrint('text empty.');
                  return;
                }
                // 共有メニューを表示
                Share.share(controller.text);
              },
            ),
            const Expanded(child: SizedBox()),
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.trash),
              backgroundColor: Colors.red[300],
              onPressed: () {
                // 入力を全クリア
                context.read<MemoModel>().clear();
                controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
