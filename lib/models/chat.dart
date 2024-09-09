import 'package:watfoe/models/message.dart';

typedef ChatId = String;

class Chat {
  final ChatId id;
  final String contactId;
  final List<Message> messages;
  final bool isTyping;
  final bool contactIsTyping;
  final String? draft;
  final bool isMuted;
  final bool isPinned;
  final bool isArchived;

  Chat({
    required this.id,
    required this.contactId,
    this.messages = const [],
    this.isTyping = false,
    this.contactIsTyping = false,
    this.draft,
    this.isMuted = false,
    this.isPinned = false,
    this.isArchived = false,
  });

  factory Chat.fromJson(Map<ChatId, dynamic> json) {
    return Chat(
      id: json['id'],
      contactId: json['contactId'],
      messages: json['messages'].map((e) => Message.fromJson(e)).toList(),
      isTyping: json['isTyping'],
      isMuted: json['isMuted'],
      isPinned: json['isPinned'],
      isArchived: json['isArchived'],
    );
  }

  Chat copyWith({
    List<Message>? messages,
    bool? isTyping,
    bool? contactIsTyping,
    String? draft,
    bool? isMuted,
    bool? isPinned,
    bool? isArchived,
  }) {
    return Chat(
      id: id,
      contactId: contactId,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      contactIsTyping: contactIsTyping ?? this.contactIsTyping,
      draft: draft ?? this.draft,
      isMuted: isMuted ?? this.isMuted,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Message? get lastMessage {
    if (messages.isEmpty) {
      return null;
    }
    return messages.last;
  }
}
