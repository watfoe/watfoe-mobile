import 'package:flutter_contacts/contact.dart';
import 'package:intl/intl.dart';

enum MessageState { queued, sending, sent, failed, unread, read }

enum MessageType { incoming, outgoing }

enum MessageAttachmentType {
  image,
  video,
  audio,
  file,
  location,
  contact,
  link,
  unknown
}

class MessageMeta {
  bool isEdited = false;

  MessageMeta({this.isEdited = false});

  static MessageMeta fromJson(Map<String, dynamic> json) {
    return MessageMeta(isEdited: json['isEdited']);
  }
}

class MessageAttachment {
  final MessageAttachmentType type;

  final String? link;
  final String? imageUrl;
  final String? videoUrl;
  final String? audioUrl;
  final String? fileUrl;
  final String? locationUrl;
  final Contact? contact;

  MessageAttachment(
      {required this.type,
      this.link,
      this.imageUrl,
      this.videoUrl,
      this.audioUrl,
      this.fileUrl,
      this.locationUrl,
      this.contact});

  static MessageAttachment fromJson(Map<String, dynamic> json) {
    const typeMap = {
      'image': MessageAttachmentType.image,
      'video': MessageAttachmentType.video,
      'audio': MessageAttachmentType.audio,
      'file': MessageAttachmentType.file,
      'location': MessageAttachmentType.location,
      'contact': MessageAttachmentType.contact,
      'link': MessageAttachmentType.link,
    };

    return MessageAttachment(
      type: typeMap[json['type']] ?? MessageAttachmentType.unknown,
      link: json['link'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      audioUrl: json['audioUrl'],
      fileUrl: json['fileUrl'],
      locationUrl: json['locationUrl'],
    );
  }
}

class Message {
  final String id;
  final MessageType type;
  final DateTime createdAt;
  final DateTime? sentAt;
  final DateTime? deliveredAt;
  final DateTime? readAt;
  final String? text;
  final MessageState state;
  final MessageAttachment? attachment;
  final MessageMeta? meta;

  Message(
      {required this.id,
      required this.type,
      required this.state,
      required this.createdAt,
      this.sentAt,
      this.deliveredAt,
      this.readAt,
      this.text,
      this.meta,
      this.attachment});

  Message copyWith({
    MessageState? state,
    DateTime? sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    String? text,
    MessageAttachment? attachment,
    MessageMeta? meta,
  }) {
    return Message(
      id: id,
      type: type,
      state: state ?? this.state,
      createdAt: createdAt,
      sentAt: sentAt ?? this.sentAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      readAt: readAt ?? this.readAt,
      text: text ?? this.text,
      attachment: attachment ?? this.attachment,
      meta: meta ?? this.meta,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    const stateMap = {
      'queued': MessageState.queued,
      'sending': MessageState.sending,
      'sent': MessageState.sent,
      'failed': MessageState.failed,
      'unread': MessageState.unread,
      'read': MessageState.read,
    };

    final message = Message(
      id: json['id'],
      type: json['type'] == 'incoming'
          ? MessageType.incoming
          : MessageType.outgoing,
      state: stateMap[json['state'] ?? 'queued']!,
      createdAt: DateTime.parse(json['createdAt']),
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      text: json['text'],
      meta: json['meta'] != null ? MessageMeta.fromJson(json['meta']) : null,
      attachment: json['attachment'] != null
          ? MessageAttachment.fromJson(json['attachment'])
          : null,
    );

    return message;
  }

  String get createdAtFormatted {
    return DateFormat.jm().format(createdAt).toLowerCase();
  }
}
