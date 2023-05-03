import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'shared_preferences_provider.dart';

final memoProvider = StateNotifierProvider<MemoNotifier, String>((ref) {
  return MemoNotifier(ref);
});

class MemoNotifier extends StateNotifier<String> {
  MemoNotifier(this._ref) : super('') {
    state = _ref.read(sharedPreferencesProvider).getString('memo') ?? '';
  }

  final Ref _ref;
  late String _current;
  String get current => _current;

  void save(String text) {
    _ref.read(sharedPreferencesProvider).setString('memo', text);
    state = text;
  }

  void clear() {
    _current = '';
    _ref.read(sharedPreferencesProvider).setString('memo', '');
    state = '';
  }
}
