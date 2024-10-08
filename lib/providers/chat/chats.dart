import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/models/chat.dart';
import 'package:watfoe/models/message.dart';

final chatsProvider =
    StateNotifierProvider<_ChatsNotifier, Map<String, Chat>>((ref) {
  return _ChatsNotifier();
});

class _ChatsNotifier extends StateNotifier<Map<String, Chat>> {
  _ChatsNotifier() : super({});

  ChatId addChat(Chat chat) {
    if (state.containsKey(chat.id)) {
      return chat.id;
    }

    chat = state.values.firstWhere(
      (_chat) => _chat.contactId == chat.contactId,
      orElse: () {
        state = {...state, chat.id: chat};
        return chat;
      },
    );

    return chat.id;
  }

  void updateChat(ChatId chatId, Chat Function(Chat) update) {
    final newState = Map<ChatId, Chat>.from(state);
    newState[chatId] = update(newState[chatId]!);
    state = newState;
  }

  void removeChat(String chatId) {
    final newState = Map<ChatId, Chat>.from(state);
    newState.remove(chatId);
    state = newState;
  }

  void addMessage(String chatId, Message message) {
    final chat = state[chatId];
    if (chat != null) {
      final updatedChat =
          chat.copyWith(messages: [...chat.messages, message], draft: '');
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

final chatIdListProvider = Provider<List<String>>((ref) {
  return ref.watch(chatsProvider.select((chats) => chats.keys.toList()));
});

final chatProvider = Provider.family<Chat?, String>((ref, chatId) {
  return ref.watch(chatsProvider.select((chats) => chats[chatId]));
});

final currentChatIdProvider = StateProvider<String?>((ref) => null);

void setCurrentChat(WidgetRef ref, String? chatId) {
  ref.read(currentChatIdProvider.notifier).state = chatId;
}
