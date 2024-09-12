import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/models/chat.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/providers/users.dart';

class UserListItem extends ConsumerStatefulWidget {
  const UserListItem(
      {super.key,
      required this.userId,
      required this.selectedContacts,
      required this.selectContact});

  final String userId;
  final List<String> selectedContacts;
  final Function(String) selectContact;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListItemState();
}

class _UserListItemState extends ConsumerState<UserListItem> {
  List<String> get selectedContacts => widget.selectedContacts;

  @override
  void initState() {
    super.initState();
  }

  _onPressed(String userId) {
    var handled = false;
    setState(() {
      if (selectedContacts.isNotEmpty) {
        widget.selectContact(userId);
        handled = true;
      }
    });

    if (!handled) {
      // User should be redirected to the empty/all chat screen
      // after navigating from the message screen
      final chatId = ref
          .read(chatsProvider.notifier)
          .addChat(Chat(id: DateTime.now().toString(), contactId: userId));
      setCurrentChat(ref, chatId);
      Navigator.pushReplacementNamed(context, 'chat/person');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider(widget.userId));
    final selected = selectedContacts.contains(widget.userId);

    return MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          _onPressed(widget.userId);
        },
        onLongPress: () {
          widget.selectContact(widget.userId);
        },
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(8, 0, 13, 0),
          minTileHeight: 68,
          leading: Avatar(
            url: user?.avatarUrl,
            radius: 21,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.displayName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(2),
              Text(
                'Tagline goes here',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: selected
              ? Container(
                  padding: const EdgeInsets.all(3),
                  // Make it rounded
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary),
                  child: Icon(FluentIcons.checkmark_16_regular,
                      color: Theme.of(context).colorScheme.onPrimary, size: 16),
                )
              : null,
          selectedTileColor: Colors.black.withAlpha(21),
          selected: selected,
        ));
  }
}
