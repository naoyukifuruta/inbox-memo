import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox_memo/providers/app_setting_provider.dart';
import 'package:inbox_memo/providers/logger_provider.dart';
import 'package:share/share.dart';

import '../providers/memo_provider.dart';
import '../providers/theme_provider.dart';
import 'setting_page.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends ConsumerState<TopPage> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final initText = ref.read(memoProvider);
    _controller = TextEditingController(text: initText);
  }

  @override
  Widget build(BuildContext context) {
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    return Scaffold(
      body: _Body(
        controller: _controller,
        focusNode: _focusNode,
      ),
      floatingActionButton: _FloatingActionButtons(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider.notifier).isDark;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: InputDecoration(
            fillColor: isDark ? Colors.grey[800] : Colors.blueGrey[50],
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.blueGrey[50]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.blueGrey[50]!,
              ),
            ),
          ),
          cursorColor: isDark ? Colors.indigo[400] : Colors.blueGrey,
          controller: controller,
          maxLines: _getTextMaxLines(context),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
          autofocus: true,
          focusNode: focusNode,
          onChanged: (text) {
            ref.read(memoProvider.notifier).save(text);
          },
        ),
      ),
    );
  }

  int _getTextMaxLines(BuildContext context) {
    final int textMaxLines = MediaQuery.of(context).size.height ~/ 100 * 2;
    return Platform.isAndroid ? textMaxLines - 1 : textMaxLines + 1;
  }
}

class _FloatingActionButtons extends ConsumerWidget {
  const _FloatingActionButtons({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 32), // 左にめり込むのでその対策
          // 設定ボタン
          FloatingActionButton(
            child: const Icon(FontAwesomeIcons.cog),
            onPressed: () async {
              ref.read(loggerProvider).debug('onPressed setting button');
              focusNode.unfocus();
              await showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                builder: (BuildContext context) {
                  return const SettingPage();
                },
              );
              FocusScope.of(context).requestFocus(focusNode);
            },
          ),
          const SizedBox(width: 16),
          // 共有ボタン
          FloatingActionButton(
            child: const Icon(FontAwesomeIcons.shareAlt),
            onPressed: () async {
              if (controller.text == '') {
                ref.read(loggerProvider).debug('text empty.');
                return;
              }
              focusNode.unfocus();
              await Share.share(controller.text);
            },
          ),
          const Expanded(child: SizedBox()),
          // メモ削除ボタン
          FloatingActionButton(
            child: const Icon(FontAwesomeIcons.trash),
            backgroundColor: Colors.red[300],
            onPressed: () async {
              ref.read(loggerProvider).debug('');
              if (controller.text == '') {
                debugPrint('text empty.');
                return;
              }

              focusNode.unfocus();

              if (ref.read(appSettingProvider).isDeleteConfirm) {
                var result = await _showDeleteConfirm(
                    context, 'メモを削除', '入力を全て削除します。よろしいですか？');
                if (!result) {
                  debugPrint('delete cancel');
                  FocusScope.of(context).requestFocus(focusNode);
                  return;
                }
              }

              ref.read(memoProvider.notifier).clear();
              controller.clear();

              FocusScope.of(context).requestFocus(focusNode);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirm(
    BuildContext context,
    String title,
    String content,
  ) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _buildDeleteConfirmDialog(context, title, content);
      },
    );
    return result;
  }

  Widget _buildDeleteConfirmDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text('キャンセル'),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            child: const Text(
              '削除',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('キャンセル'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text(
              '削除',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    }
  }
}
