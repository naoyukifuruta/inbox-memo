import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoModel extends ChangeNotifier {
  late String _initialText;
  String get initialText => _initialText;

  late SharedPreferences _pref;

  MemoModel(SharedPreferences pref) {
    _pref = pref;
    _initialText = load();
  }

  String load() {
    return _pref.getString('memo') ?? '';
  }

  void save(String text) {
    _pref.setString('memo', text);
  }
}
