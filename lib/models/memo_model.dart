import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoModel extends ChangeNotifier {
  late SharedPreferences _pref;

  late String _current;
  String get current => _current;

  bool get isDeleteConfirm => _isDeleteConfirm;
  bool _isDeleteConfirm = false;

  MemoModel(SharedPreferences pref) {
    _pref = pref;
    _current = load();
    _isDeleteConfirm = pref.getBool('isDeleteConfirm') ?? false;
  }

  String load() {
    return _pref.getString('memo') ?? '';
  }

  void save(String text) {
    _pref.setString('memo', text);
  }

  void clear() {
    _current = '';
    _pref.setString('memo', '');
    notifyListeners();
  }

  void changeDeleteConfirmMode() {
    _isDeleteConfirm = !_isDeleteConfirm;
    _pref.setBool('isDeleteConfirm', _isDeleteConfirm);
    notifyListeners();
  }
}
