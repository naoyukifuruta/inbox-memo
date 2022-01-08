import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'models/memo_model.dart';

class MemoPage extends StatelessWidget {
  MemoPage({Key? key, required this.initText}) : super(key: key) {
    controller = TextEditingController(text: initText);
  }

  String initText;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('### MemoPage build ###');
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
                borderSide: BorderSide(
                  color: Colors.blueGrey[50]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey[50]!,
                ),
              ),
            ),
            cursorColor: Colors.blueGrey,
            controller: controller,
            maxLines: textMaxLines,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
            autofocus: true,
            onChanged: (text) {
              Provider.of<MemoModel>(context, listen: false).save(text);
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
              onPressed: () {
                // TODO: 設定画面へ遷移
              },
            ),
            const Expanded(child: SizedBox()),
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.shareAlt),
              onPressed: () {
                // TODO: 共有
              },
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              child: const Icon(FontAwesomeIcons.trash),
              backgroundColor: Colors.red[300],
              onPressed: () {
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
