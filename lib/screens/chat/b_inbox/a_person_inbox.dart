import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/components/appbar/screen.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/screens/chat/b_inbox/input_area.dart';

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
    final contact = ModalRoute.of(context)?.settings.arguments as Contact;

    return Scaffold(
      appBar: buildScreenAppBar(context,
          showAvatar: true,
          title: contact.displayName,
          actions: [
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
          ]),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InputArea(
                contactId: contact.id,
              )
            ],
          )),
    );
  }
}
