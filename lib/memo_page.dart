import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'models/app_info_model.dart';
import 'models/memo_model.dart';
import 'models/theme_model.dart';
import 'setting_page.dart';

class MemoPage extends StatelessWidget {
  MemoPage({Key? key, required this.initText}) : super(key: key) {
    controller = TextEditingController(text: initText);
  }

  String initText;
  late TextEditingController controller;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    final int textMaxLines = MediaQuery.of(context).size.height ~/ 100 * 2;
    final isDark = context.read<ThemeModel>().isDark;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: isDark ? Colors.grey[800] : Colors.blueGrey[50],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isDark ? Colors.grey[800]! : Colors.blueGrey[50]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isDark ? Colors.grey[800]! : Colors.blueGrey[50]!),
              ),
            ),
            cursorColor: isDark ? Colors.indigo[400] : Colors.blueGrey,
            controller: controller,
            maxLines: textMaxLines,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black, fontSize: 16.0),
            autofocus: true,
            focusNode: _focusNode,
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
                if (_focusNode.hasFocus) {
                  _focusNode.unfocus();
                } else {
                  // TODO: こっちを通るときにモーダルがキーボードに隠れてしまう
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
              onPressed: () async {
                if (controller.text == '') {
                  debugPrint('text empty.');
                  return;
                }
                context.read<MemoModel>().clear();
                controller.clear();

                _focusNode.requestFocus();

                // TODO: このルート通ったときにキーボードがきえない問題（iOS/Android両方）
              },
            ),
          ],
        ),
      ),
    );
  }
}
