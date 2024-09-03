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
    return Row(
        mainAxisAlignment: message.type == MessageType.incoming
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
            decoration: BoxDecoration(
              color: message.type == MessageType.incoming
                  ? colorPrimary6.withAlpha(55)
                  : Colors.black.withAlpha(16),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              message.text != null
                  ? Text(message.text!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400))
                  : const SizedBox(),
              message.attachment != null &&
                      message.attachment!.type == MessageAttachmentType.link
                  ? Column(
                      children: [
                        const Gap(5),
                        _buildLinkAttachment(message.attachment!.link!)
                      ],
                    )
                  : const SizedBox(),
              message.type == MessageType.incoming
                  ? _buildMessageTime()
                  : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      _buildMessageTime(),
                      const Gap(5),
                      _buildMessageStateIcon(),
                      // _buildStateIcon()
                    ]),
            ]),
          )
        ]);
  }

  Widget _buildMessageTime() {
    final time = DateFormat.jm().format(message.createdAt);

    return Text(
      time,
      style: const TextStyle(
          color: colorNeutral7, fontSize: 12, fontWeight: FontWeight.w400),
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
        return const Icon(Symbols.done_all_rounded,
            color: colorPrimary6, size: 16);
      case MessageState.queued:
      case MessageState.sending:
      default:
        return const Icon(Icons.access_time, color: colorNeutral6, size: 15);
    }
  }

  Widget _buildAttachment() {
    if (message.attachment == null) {
      return const SizedBox();
    }

    final attachment = message.attachment;
    switch (attachment!.type) {
      case MessageAttachmentType.link:
        return _buildLinkAttachment(attachment.link!);
      default:
        return const SizedBox();
    }
  }

  Widget _buildLinkAttachment(String link) {
    return LinkPreviewer(url: link);
  }
}
