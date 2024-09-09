import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/providers/users.dart';
import 'package:watfoe/screens/chat/b_inbox/c_conversation_thread.dart';
import 'package:watfoe/screens/chat/b_inbox/c_input_area.dart';

class PersonConversationScreen extends ConsumerStatefulWidget {
  const PersonConversationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonConversationScreenState();
}

class _PersonConversationScreenState
    extends ConsumerState<PersonConversationScreen> {
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
    final chatId = ref.watch(currentChatIdProvider);
    final contactId =
        ref.watch(chatProvider(chatId!).select((chat) => chat?.contactId));
    final displayName =
        ref.watch(userProvider(contactId!).select((user) => user?.displayName));

    return WatfoeScaffold(
      showAppBarAvatar: true,
      appBarTitle: displayName,
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
  }
}
