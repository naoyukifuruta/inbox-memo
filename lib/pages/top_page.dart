import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  //late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  TextStyle hyperLinkStyleO =
      const TextStyle(color: Colors.blue, decoration: TextDecoration.underline);
  late LinkedTextEditingControllerO _controller;

  @override
  void initState() {
    super.initState();
    final initText = ref.read(memoProvider);
    // _controller = TextEditingController(text: initText);
    _controller = LinkedTextEditingControllerO(
      textO: initText,
      linkStyleO: hyperLinkStyleO,
    );
  }

  @override
  void dispose() {
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
                ref.read(loggerProvider).debug('text empty');
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

class LinkedTextEditingControllerO extends TextEditingController {
  final RegExp linkRegexpO;
  final TextStyle linkStyleO;
  final Function(String matchO) onTapO;

  static final RegExp _defaultRegExpO = RegExp(
    r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&=#]*)?',
    caseSensitive: false,
    dotAll: true,
  );

  static void _defaultOnLaunchO(String fullUrlO) async {
    if (await canLaunch(fullUrlO)) {
      await launch(fullUrlO);
    }
  }

  LinkedTextEditingControllerO({
    String? textO,
    RegExp? regexp,
    required this.linkStyleO,
    this.onTapO = _defaultOnLaunchO,
  })  : linkRegexpO = regexp ?? _defaultRegExpO,
        super(text: textO);

  @override
  TextSpan buildTextSpan({
    BuildContext? context,
    TextStyle? style,
    bool? withComposing,
  }) {
    List<TextSpan> childrenO = [];
    text.splitMapJoin(
      linkRegexpO,
      onMatch: (Match matchO) {
        debugPrint('Match!');
        childrenO.add(
          TextSpan(
            text: matchO[0],
            style: linkStyleO,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTapO(matchO[0]!),
          ),
        );
        return "";
      },
      onNonMatch: (String spanO) {
        debugPrint('No Match');
        childrenO.add(TextSpan(text: spanO, style: style));
        return "";
      },
    );
    return TextSpan(style: style, children: childrenO);
  }
}
