import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'shared_preferences_provider.dart';

final memoProvider = StateNotifierProvider<MemoNotifier, String>((ref) {
  return MemoNotifier(ref.read);
});

class MemoNotifier extends StateNotifier<String> {
  MemoNotifier(this._read) : super('') {
    state = _read(sharedPreferencesProvider).getString('memo') ?? '';
  }

  final Reader _read;
  late String _current;
  String get current => _current;

  void save(String text) {
    _read(sharedPreferencesProvider).setString('memo', text);
    state = text;
  }

  void clear() {
    _current = '';
    _read(sharedPreferencesProvider).setString('memo', '');
    state = '';
  }
}
