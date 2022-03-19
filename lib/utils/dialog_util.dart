import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static Future<bool> showDeleteConfirm(
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

  static Widget _buildDeleteConfirmDialog(
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
