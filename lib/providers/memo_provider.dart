import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'shared_preferences_provider.dart';

const _memoPrefsKey = 'memo';

final memoProvider = StateNotifierProvider<MemoNotifier, String>(
  (ref) {
    return MemoNotifier(ref);
  },
);

class MemoNotifier extends StateNotifier<String> {
  MemoNotifier(this._ref) : super('') {
    state = _prefs.getString(_memoPrefsKey) ?? '';
  }

  final Ref _ref;
  late final _prefs = _ref.read(sharedPreferencesProvider);

  // メモ保存
  void save(String text) {
    _ref.read(sharedPreferencesProvider).setString(_memoPrefsKey, text);
    state = text;
  }

  // メモ削除
  void clear() {
    _ref.read(sharedPreferencesProvider).setString(_memoPrefsKey, '');
    state = '';
  }
}
