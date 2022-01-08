import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'models/memo_model.dart';

class MemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    debugPrint(size.height.toString());
    final int textMaxLines = (size.height / 100).toInt();
    debugPrint(textMaxLines.toString());
    return Consumer<MemoModel>(
      builder: (context, model, child) {
        final controller = TextEditingController(text: model.current);
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
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
                  model.current = text;
                },
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  child: const Icon(FontAwesomeIcons.trash),
                  backgroundColor: Colors.red[300],
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  child: const Icon(FontAwesomeIcons.cog),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
