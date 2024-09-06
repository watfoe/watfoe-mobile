import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/providers/chat/inbox/input_area.dart';
import 'package:watfoe/screens/chat/b_inbox/media_picker.dart';
import 'package:watfoe/theme/color_scheme.dart';

class InputArea extends ConsumerStatefulWidget {
  const InputArea({super.key, required this.contactId});

  final String contactId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputAreaState();
}

class _InputAreaState extends ConsumerState<InputArea> {
  TextEditingController? messageController;

  String get contactId => widget.contactId;

  @override
  initState() {
    super.initState();

    // If the user has already typed a message to this contact, restore it
    messageController = TextEditingController(
      text: ref.read(textMessageValueProvider).containsKey(contactId)
          ? ref.read(textMessageValueProvider)[contactId]
          : '',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageController!.addListener(() {
        final value = messageController!.text;
        // final lines = value.split('\n');
        // if (lines.length > 1) {
        //   setState(() {
        //     maxLines = lines.length;
        //   });
        // }
        ref
            .read(textMessageValueProvider.notifier)
            .setValue({contactId: value});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(isEditingProvider)[contactId] ?? false;

    return AnimatedSize(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withAlpha(16),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            isEditing
                ? _TextInputField(
                    controller: messageController, contactId: contactId)
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
                      child: isEditing
                          ? const Row()
                          : _TextInputField(
                              contactId: contactId,
                            )),
                  ButtonIcon(
                    icon: FluentIcons.camera_24_regular,
                    fgcolor: colorNeutral7,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const MediaPickerScreen(),
                        useSafeArea: false,
                      );
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
                  _SendRecordButton(contactId: contactId),
                ])
          ]),
        ));
  }
}

class _TextInputField extends ConsumerStatefulWidget {
  const _TextInputField({required this.contactId, this.controller});

  final String contactId;
  final TextEditingController? controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends ConsumerState<_TextInputField> {
  TextEditingController? get controller => widget.controller;

  String get contactId => widget.contactId;

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(isEditingProvider)[contactId] ?? false;

    return TextField(
      autofocus: isEditing,
      controller: controller,
      cursorHeight: 16,
      keyboardType: TextInputType.multiline,
      maxLines: isEditing ? 1 : 1,
      decoration: InputDecoration(
          hintText: 'Message',
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(isEditing ? 17 : 0, 25, 0, 0),
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
      onTap: () {
        if (!isEditing) {
          ref.read(isEditingProvider.notifier).toggleOn(contactId);
        }
      },
      onTapOutside: (_) {
        if (isEditing && controller != null && controller!.text.isEmpty) {
          ref.read(isEditingProvider.notifier).toggleOff(contactId);
        }
      },
    );
  }
}

class _SendRecordButton extends ConsumerStatefulWidget {
  const _SendRecordButton({required this.contactId});

  final String contactId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendRecordButtonState();
}

class _SendRecordButtonState extends ConsumerState<_SendRecordButton> {
  String get contactId => widget.contactId;

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(textMessageValueProvider);
    final isEditing = ref.watch(isEditingProvider)[contactId] ?? false;

    return ButtonIcon(
      icon: value.isNotEmpty && isEditing
          ? FluentIcons.play_24_regular
          : Symbols.graphic_eq_rounded,
      onPressed: () {},
      bgcolor: Theme.of(context).colorScheme.primary,
      fgcolor: Theme.of(context).colorScheme.onPrimary,
      tooltip: value.isEmpty ? 'Record voice' : 'Send message',
    );
  }
}
