import 'package:flutter_riverpod/flutter_riverpod.dart';

class _IsEditing extends StateNotifier<Map<String, bool>> {
  _IsEditing() : super({});

  void toggleOff(String contactId) {
    state = {...state, contactId: false};
  }

  void toggleOn(String contactId) {
    state = {...state, contactId: true};
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
