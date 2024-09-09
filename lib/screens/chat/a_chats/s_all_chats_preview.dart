import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';
import 'package:watfoe/providers/chat/chats.dart';

class AllChatsPreviewScreen extends ConsumerStatefulWidget {
  const AllChatsPreviewScreen({super.key});

  @override
  ConsumerState<AllChatsPreviewScreen> createState() =>
      _AllChatsPreviewScreenState();
}

class _AllChatsPreviewScreenState extends ConsumerState<AllChatsPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return WatfoeScaffold(
      appBarAvatarUrl: "https://cdn.watfoe.com/i/watfoe-logo.png",
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
      body: const _ChatsList(),
      floatingActionButton: _buildNewChatButton(context),
    );
  }

  Widget _buildNewChatButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {
        Navigator.pushNamed(context, 'chat/new');
      },
      tooltip: 'New Chat',
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.primary,
      shape: const CircleBorder(),
      child: const Icon(
        FluentIcons.chat_add_28_filled,
        size: 48,
      ),
    );
  }
}

class _ChatsList extends ConsumerWidget {
  const _ChatsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatIds = ref.watch(chatIdListProvider);

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _ChatItem(chatId: chatIds[index]),
            childCount: chatIds.length,
          ),
        ),
      ],
    );
  }
}

class _ChatItem extends ConsumerWidget {
  const _ChatItem({required this.chatId});

  final String chatId;

  _onPressed(BuildContext context, WidgetRef ref, String chatId) {
    setCurrentChat(ref, chatId);
    Navigator.pushNamed(context, 'chat/inbox/person');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chat = ref.watch(chatProvider(chatId));

    return MaterialButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        _onPressed(context, ref, chatId);
      },
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 13, 0),
        leading: Avatar(
          radius: 21,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chat?.lastMessage?.text ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1),
                ),
                Text(
                  chat?.lastMessage?.createdAtFormatted ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const Gap(8),
            Text(
              chat?.lastMessage?.text ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
