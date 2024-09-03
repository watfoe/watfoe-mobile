import 'package:flutter_riverpod/flutter_riverpod.dart';

class _IsEditing extends StateNotifier<Map<String, bool>> {
  _IsEditing() : super({});

  void toggle(String contactId) {
    if (state.containsKey(contactId)) {
      state.remove(contactId);
    } else {
      state = {...state, contactId: true};
    }
  }
}

final isEditingProvider =
    StateNotifierProvider<_IsEditing, Map<String, bool>>((ref) {
  return _IsEditing();
});

class _TextMessageValue extends StateNotifier<Map<String, String>> {
  _TextMessageValue() : super({});

  void setValue(Map<String, String> value) {
    state = {...state, ...value};
  }
}

final textMessageValueProvider =
    StateNotifierProvider<_TextMessageValue, Map<String, String>>((ref) {
  return _TextMessageValue();
});
