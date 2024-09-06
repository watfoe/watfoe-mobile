import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:watfoe/components/linkpreview/linkpreviewer.dart';
import 'package:watfoe/models/message.dart';
import 'package:watfoe/theme/color_scheme.dart';

class MessageContainer extends ConsumerStatefulWidget {
  const MessageContainer({super.key, required this.message});

  final Message message;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageContainerState();
}

class _MessageContainerState extends ConsumerState<MessageContainer> {
  Message get message => widget.message;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        child: Column(
            crossAxisAlignment: message.type == MessageType.incoming
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  child: GestureDetector(
                      onDoubleTap: () {
                        // Like the message
                      },
                      onLongPress: () {
                        // Select the message
                        // Show message options
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: message.type == MessageType.incoming
                              ? colorPrimary6.withAlpha(44)
                              : Colors.black.withAlpha(16),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: message.attachment == null
                            ? _buildText()
                            : Column(
                                children: [
                                  _buildAttachment(),
                                  const Gap(5),
                                  _buildText(),
                                ],
                              ),
                      ))),
              message.type == MessageType.incoming
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: _buildMessageTime())
                  : Padding(
                      padding: const EdgeInsets.only(right: 10, top: 2),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildMessageTime(),
                            const Gap(5),
                            _buildMessageStateIcon(),
                            // _buildStateIcon()
                          ])),
            ]));
  }

  Widget _buildText() {
    if (message.text == null) {
      return Container();
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        child: Text(
          message.text!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ));
  }

  Widget _buildMessageTime() {
    final time = DateFormat.jm().format(message.createdAt).toLowerCase();

    return Text(
      time,
      style: const TextStyle(
          color: colorNeutral7,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          height: 1),
    );
  }

  Widget _buildMessageStateIcon() {
    switch (message.state) {
      case MessageState.sent:
        return const Icon(Symbols.check_rounded,
            color: colorNeutral7, size: 16);
      case MessageState.failed:
        return const Icon(Symbols.error_rounded, color: colorDanger6, size: 15);
      case MessageState.unread:
        return const Icon(Symbols.done_all_rounded,
            color: colorNeutral6, size: 16);
      case MessageState.read:
        return const Icon(Symbols.done_all_rounded, size: 16);
      case MessageState.queued:
      case MessageState.sending:
      default:
        return const Icon(Icons.access_time, color: colorNeutral6, size: 16);
    }
  }

  Widget _buildAttachment() {
    final attachment = message.attachment;
    switch (attachment!.type) {
      case MessageAttachmentType.link:
        return _buildLinkAttachment(attachment.link!);
      default:
        return Container();
    }
  }

  Widget _buildLinkAttachment(String link) {
    return LinkPreviewer(url: link);
  }
}
