import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

final memoProvider = StateNotifierProvider<MemoObserver, String>((ref) {
  return MemoObserver(ref);
});

class MemoObserver extends StateNotifier<String> {
  MemoObserver(this._ref) : super('') {
    _pref = _ref.read(sharedPreferencesProvider);
    state = _pref.getString('memo') ?? '';
  }

  final Ref _ref;
  late final SharedPreferences _pref;

  late String _current;
  String get current => _current;

  void save(String text) {
    _pref.setString('memo', text);
    state = text;
  }

  void clear() {
    _current = '';
    _pref.setString('memo', '');
    state = '';
  }
}
