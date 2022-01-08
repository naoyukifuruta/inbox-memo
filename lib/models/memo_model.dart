import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoModel extends ChangeNotifier {
  String _current = '';

  String get current => _current;
  set current(String str) {
    _current = str;
    _pref.setString('memo', _current);
  }

  late SharedPreferences _pref;

  MemoModel(SharedPreferences pref) {
    _pref = pref;
    _current = pref.getString('memo') ?? '';
  }
}
