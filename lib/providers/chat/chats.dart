import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/models/chat.dart';
import 'package:watfoe/models/message.dart';

final chatsProvider =
    StateNotifierProvider<_ChatsNotifier, Map<String, Chat>>((ref) {
  return _ChatsNotifier();
});

class _ChatsNotifier extends StateNotifier<Map<String, Chat>> {
  _ChatsNotifier() : super({});

  void addChat(Chat chat) {
    if (state.containsKey(chat.id)) {
      return;
    }

    state = {...state, chat.id: chat};
  }

  void updateChat(
    String chatId, {
    List<Message>? messages,
    bool? isTyping,
    bool? contactIsTyping,
    String? draft,
    bool? isMuted,
    bool? isPinned,
    bool? isArchived,
  }) {
    final chat = state[chatId];

    if (chat != null) {
      final updatedChat = chat.copyWith(
        messages: messages,
        isTyping: isTyping,
        contactIsTyping: contactIsTyping,
        draft: draft,
        isMuted: isMuted,
        isPinned: isPinned,
        isArchived: isArchived,
      );
      state = {...state, chatId: updatedChat};
    }
  }

  void removeChat(String chatId) {
    final newState = Map<String, Chat>.from(state);
    newState.remove(chatId);
    state = newState;
  }

  void addMessage(String chatId, Message message) {
    final chat = state[chatId];
    if (chat != null) {
      final updatedChat = chat.copyWith(messages: [...chat.messages, message]);
      state = {...state, chatId: updatedChat};
    }
  }

  void removeMessage(String chatId, String messageId) {
    final chat = state[chatId];
    if (chat != null) {
      final updatedChat = chat.copyWith(
        messages:
            chat.messages.where((message) => message.id != messageId).toList(),
      );
      state = {...state, chatId: updatedChat};
    }
  }
}

final chatProvider = Provider.family<Chat?, String>((ref, chatId) {
  return ref.watch(chatsProvider.select((chats) => chats[chatId]));
});

final currentChatIdProvider = StateProvider<String?>((ref) => null);

void setCurrentChat(WidgetRef ref, String? chatId) {
  ref.read(currentChatIdProvider.notifier).state = chatId;
}
