import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/providers/contacts.dart';
import 'package:watfoe/screens/chat/b_inbox/input_area.dart';
import 'package:watfoe/screens/chat/b_inbox/messages_area.dart';

class PersonInbox extends ConsumerStatefulWidget {
  const PersonInbox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonInboxState();
}

class _PersonInboxState extends ConsumerState<PersonInbox> {
  TextEditingController messageController = TextEditingController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageController.addListener(() {
        // final lines = messageController.text.split('\n');
        // if (lines.length > 1) {
        //   setState(() {
        //     maxLines = lines.length;
        //   });
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactsFut = ref.watch(contactsProvider);
    return contactsFut.when(
        data: (contacts) {
          final chatId = ref.watch(currentChatIdProvider);
          final contactId = ref
              .watch(chatProvider(chatId!).select((chat) => chat?.contactId));
          final contact =
              contacts.firstWhere((contact) => contact.id == contactId);

          return WatfoeScaffold(
            showAppBarAvatar: true,
            appBarTitle: contact.displayName,
            appBarActions: [
              ButtonIcon(
                icon: FluentIcons.wallet_credit_card_24_regular,
                onPressed: () {},
                tooltip: 'Pay',
              ),
              RotatedBox(
                  quarterTurns: -1,
                  child: ButtonIcon(
                    icon: FluentIcons.call_end_24_regular,
                    onPressed: () {},
                    tooltip: 'Call',
                  )),
              ButtonIcon(
                icon: FluentIcons.more_vertical_24_regular,
                onPressed: () {},
                tooltip: 'Options',
              ),
            ],
            body: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: MessagesArea(chatId: chatId),
                ),
                const Gap(8),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: InputArea(chatId: chatId))
              ],
            ),
          );
        },
        error: (error, _) => Container(),
        loading: () => Container());
  }
}
