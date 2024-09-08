import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';
import 'package:watfoe/models/chat.dart';
import 'package:watfoe/providers/chat/chats.dart';

class AllChatsPreview extends ConsumerStatefulWidget {
  const AllChatsPreview({super.key});

  @override
  ConsumerState<AllChatsPreview> createState() => _AllChatsPreviewState();
}

class _AllChatsPreviewState extends ConsumerState<AllChatsPreview> {
  int currentPageIndex = 0;

  List<Chat> _chats = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chats = ref.watch(chatsProvider);
      if (chats.isEmpty) {
        Navigator.pushReplacementNamed(context, 'chat/empty');
      }
    });

    return WatfoeScaffold(
      appBarTitle: 'Chat',
      appBarActions: [
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
      ],
      showBottomNavigationBar: true,
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
