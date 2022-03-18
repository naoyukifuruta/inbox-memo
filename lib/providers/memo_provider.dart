import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

final memoProvider = StateNotifierProvider<MemoNotifier, String>((ref) {
  return MemoNotifier(ref);
});

class MemoNotifier extends StateNotifier<String> {
  MemoNotifier(Ref ref) : super('') {
    _pref = ref.read(sharedPreferencesProvider);
    state = _pref.getString('memo') ?? '';
  }

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
