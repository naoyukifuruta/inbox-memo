import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inbox_memo/extensions/theme_mode_extension.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/app_setting_provider.dart';
import '../providers/memo_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/dialog_util.dart';
import 'setting_page.dart';

class TopPage extends HookConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: ref.read(memoProvider));
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    final focusNode = useFocusNode();
    return Scaffold(
      body: _Body(
        controller: controller,
        focusNode: focusNode,
      ),
      floatingActionButton: _FloatingActionButtons(
        controller: controller,
        focusNode: focusNode,
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
    //return Platform.isAndroid ? textMaxLines : textMaxLines + 1;
    return textMaxLines + 1;
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
          _SettingButton(focusNode: focusNode),
          const SizedBox(width: 16),
          _ShareButton(controller: controller, focusNode: focusNode),
          const Expanded(child: SizedBox()),
          _DeleteButton(controller: controller, focusNode: focusNode),
        ],
      ),
    );
  }
}

class _SettingButton extends StatelessWidget {
  const _SettingButton({
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.settings),
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
        focusNode.requestFocus();
      },
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.share),
      onPressed: () async {
        if (controller.text == '') {
          return;
        }
        focusNode.unfocus();
        await Share.share(controller.text, subject: controller.text);
      },
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      backgroundColor: Colors.red[300],
      child: const Icon(Icons.delete),
      onPressed: () async {
        // 未入力の場合は何もしない
        if (controller.text == '') {
          return;
        }

        // 削除確認を行う場合はダイアログを表示
        if (ref.read(appSettingProvider).isDeleteConfirm) {
          var result = await DialogUtil.showDeleteConfirm(
            context,
            '確認',
            'メモを全て削除します。よろしいですか？',
          );
          // キャンセル時はフォーカスを戻して終了
          if (!result) {
            focusNode.requestFocus();
            return;
          }
        }

        // 削除
        ref.read(memoProvider.notifier).clear();

        // コントローラーを初期化してフォーカスを戻す
        controller.clear();
        focusNode.requestFocus();
      },
    );
  }
}
