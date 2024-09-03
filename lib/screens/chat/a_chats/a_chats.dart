import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/appbar/tabscreen.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/navigation/a_main/b_bottom_navigation.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTabscreenAppBar(context, title: 'Chat', actions: [
        RotatedBox(
            quarterTurns: -1,
            child: ButtonIcon(
              icon: FluentIcons.call_end_24_regular,
              onPressed: () {},
              tooltip: 'Calls',
            )),
        ButtonIcon(
          icon: FluentIcons.search_24_regular,
          onPressed: () {},
          tooltip: 'Search chats',
        ),
        ButtonIcon(
          icon: FluentIcons.more_vertical_24_regular,
          onPressed: () {},
          tooltip: 'More chat options',
        ),
      ]),
      bottomNavigationBar: const BottomNavigation(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Gap(30)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'chat/new');
        },
        tooltip: 'New Chat',
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Icon(FluentIcons.chat_add_28_regular),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
