import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox_memo/providers/app_setting_provider.dart';
import 'package:inbox_memo/providers/logger_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/memo_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/dialog_util.dart';
import 'setting_page.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends ConsumerState<TopPage> {
  late final TextEditingControllerWrapper _controller;
  //late final TextEditingController _controller; // debug用
  final FocusNode _focusNode = FocusNode();

  TextStyle hyperLinkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  @override
  void initState() {
    super.initState();
    final initText = ref.read(memoProvider);
    _controller = TextEditingControllerWrapper(
      text: initText,
      linkTextStyle: hyperLinkStyle,
    );
    //_controller = TextEditingController(text: initText); //debug用
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    final theme = ref.watch(themeProvider);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: InputDecoration(
            fillColor: theme.isDark ? Colors.grey[800] : Colors.blueGrey[50],
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.isDark ? Colors.grey[800]! : Colors.blueGrey[50]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.isDark ? Colors.grey[800]! : Colors.blueGrey[50]!,
              ),
            ),
          ),
          cursorColor: theme.isDark ? Colors.indigo[400] : Colors.blueGrey,
          controller: controller,
          maxLines: _getTextMaxLines(context),
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
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
            child: const Icon(FontAwesomeIcons.solidShareSquare),
            onPressed: () async {
              if (controller.text == '') {
                return;
              }
              focusNode.unfocus();
              await Share.share(controller.text);
            },
          ),
          const Expanded(child: SizedBox()),
          // クリップボードからコピーボタン
          // FloatingActionButton(
          //   child: const Icon(FontAwesomeIcons.clipboard),
          //   backgroundColor: Colors.green[400],
          //   onPressed: () async {
          //     final data = await Clipboard.getData("text/plain");
          //     if (data == null) {
          //       return;
          //     }
          //     final nowText = controller.text;
          //     if (nowText.isEmpty) {
          //       controller.text = data.text!;
          //     } else {
          //       controller.text = nowText + '\n' + data.text!;
          //     }
          //     controller.selection = TextSelection.fromPosition(
          //       TextPosition(offset: controller.text.length),
          //     );
          //   },
          // ),
          // const SizedBox(width: 16),
          // メモ削除ボタン
          FloatingActionButton(
            child: const Icon(FontAwesomeIcons.trash),
            backgroundColor: Colors.red[300],
            onPressed: () async {
              if (controller.text == '') {
                ref.read(loggerProvider).debug('text empty');
                return;
              }

              if (ref.read(appSettingProvider).isDeleteConfirm) {
                var result = await DialogUtil.showDeleteConfirm(
                    context, 'メモを削除', '入力を全て削除します。よろしいですか？');
                if (!result) {
                  ref.read(loggerProvider).debug('delete cancel');
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
}

// URLをハイパーリンクにするTextEditingControllerのラッパークラス
// memo: iOSシミュレータだと例外が飛ぶ時がある
class TextEditingControllerWrapper extends TextEditingController {
  final RegExp linkRegExp;
  final TextStyle linkTextStyle;
  final Function(String matched) onLinkTextTap;

  static final RegExp _defaultRegExp = RegExp(
    r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&=#]*)?',
    caseSensitive: false,
    dotAll: true,
  );

  static void _defaultOnLaunch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  TextEditingControllerWrapper({
    String? text,
    RegExp? regexp,
    required this.linkTextStyle,
    this.onLinkTextTap = _defaultOnLaunch,
  })  : linkRegExp = regexp ?? _defaultRegExp,
        super(text: text);

  @override
  TextSpan buildTextSpan({
    BuildContext? context,
    TextStyle? style,
    bool? withComposing,
  }) {
    List<TextSpan> children = [];
    text.splitMapJoin(
      linkRegExp,
      onMatch: (Match match) {
        children.add(
          TextSpan(
            text: match[0],
            style: linkTextStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onLinkTextTap(match[0]!),
          ),
        );
        return "";
      },
      onNonMatch: (String span) {
        children.add(TextSpan(text: span, style: style));
        return "";
      },
    );
    return TextSpan(style: style, children: children);
  }
}
