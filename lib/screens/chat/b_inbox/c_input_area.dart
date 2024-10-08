import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/models/message.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/screens/chat/b_inbox/media_picker/media_picker.dart';
import 'package:watfoe/theme/color_scheme.dart';

class InputArea extends ConsumerStatefulWidget {
  const InputArea({super.key, required this.chatId});

  final String chatId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputAreaState();
}

class _InputAreaState extends ConsumerState<InputArea> {
  TextEditingController messageController = TextEditingController();

  _onSend() {
    final value = messageController.text;
    if (value.isNotEmpty) {
      messageController.clear();
      ref.read(chatsProvider.notifier).addMessage(
          widget.chatId,
          Message(
            id: DateTime.now().toIso8601String(),
            type: MessageType.outgoing,
            state: MessageState.queued,
            text: value,
            createdAt: DateTime.now(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTyping = ref.watch(
            chatProvider(widget.chatId).select((chat) => chat?.isTyping)) ??
        false;

    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(16),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        isTyping
            ? _TextInputField(
                controller: messageController,
                chatId: widget.chatId,
                onSend: _onSend)
            : const SizedBox(),
        Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonIcon(
                icon: FluentIcons.flash_sparkle_24_regular,
                fgcolor: colorNeutral7,
                onPressed: () {},
                tooltip: 'Watfoe Ai',
              ),
              Flexible(
                  child: isTyping
                      ? const Row()
                      : _TextInputField(
                          chatId: widget.chatId,
                        )),
              ButtonIcon(
                icon: FluentIcons.camera_24_regular,
                fgcolor: colorNeutral7,
                onPressed: () {
                  showBottomSheet(
                      enableDrag: true,
                      showDragHandle: true,
                      context: context,
                      backgroundColor: colorNeutral0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      builder: (context) => const MediaPickerScreen());
                },
                tooltip: 'Take photo',
              ),
              ButtonIcon(
                icon: FluentIcons.add_circle_24_regular,
                fgcolor: colorNeutral7,
                onPressed: () {},
                tooltip: 'Add attachment',
              ),
              const Gap(3),
              _SendRecordButton(chatId: widget.chatId, onSend: _onSend),
            ])
      ]),
    );
  }
}

class _TextInputField extends ConsumerStatefulWidget {
  const _TextInputField({required this.chatId, this.controller, this.onSend});

  final String chatId;
  final TextEditingController? controller;
  final void Function()? onSend;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends ConsumerState<_TextInputField> {
  TextEditingController? get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final isTyping = ref.watch(
            chatProvider(widget.chatId).select((chat) => chat?.isTyping)) ??
        false;

    controller?.text =
        ref.watch(chatProvider(widget.chatId).select((chat) => chat?.draft)) ??
            '';

    return TextField(
      autofocus: isTyping,
      controller: controller,
      cursorHeight: 16,
      keyboardType: TextInputType.multiline,
      maxLines: isTyping ? 1 : 1,
      decoration: InputDecoration(
          hintText: 'Message',
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(isTyping ? 17 : 0, 25, 13, 0),
          hintStyle: const TextStyle(
              color: colorNeutral7, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide.none)),
      style: const TextStyle(
        fontSize: 18,
      ),
      onChanged: (value) {
        ref
            .read(chatsProvider.notifier)
            .updateChat(widget.chatId, (chat) => chat.copyWith(draft: value));
      },
      onTap: () {
        if (!isTyping) {
          ref.read(chatsProvider.notifier).updateChat(
              widget.chatId, (chat) => chat.copyWith(isTyping: true));
        }
      },
      onTapOutside: (_) {
        if (isTyping && controller != null && controller!.text.isEmpty) {
          ref.read(chatsProvider.notifier).updateChat(
              widget.chatId, (chat) => chat.copyWith(isTyping: false));
        }
      },
      onSubmitted: (_) {
        if (widget.onSend != null) {
          widget.onSend!();
        }
      },
    );
  }
}

class _SendRecordButton extends ConsumerStatefulWidget {
  const _SendRecordButton({required this.chatId, required this.onSend});

  final String chatId;
  final void Function() onSend;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendRecordButtonState();
}

class _SendRecordButtonState extends ConsumerState<_SendRecordButton> {
  @override
  Widget build(BuildContext context) {
    final draft =
        ref.watch(chatProvider(widget.chatId).select((chat) => chat?.draft));
    final hasDraft = draft?.isNotEmpty ?? false;

    return ButtonIcon(
      icon: hasDraft
          ? FluentIcons.arrow_up_24_regular
          : Symbols.graphic_eq_rounded,
      onPressed: () {
        if (hasDraft) {
          widget.onSend();
        } else {}
      },
      bgcolor: Theme.of(context).colorScheme.primary,
      fgcolor: Theme.of(context).colorScheme.onPrimary,
      tooltip: hasDraft ? 'Send message' : 'Record voice',
    );
  }
}
