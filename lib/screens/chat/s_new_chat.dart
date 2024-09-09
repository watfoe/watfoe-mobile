import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';
import 'package:watfoe/models/chat.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/providers/users.dart';
import 'package:watfoe/theme/color_scheme.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewChatScreen();
}

class _NewChatScreen extends State<NewChatScreen> {
  List<String> selectedContacts = [];
  bool searchBarVisible = false;

  _selectContact(String contactId) {
    setState(() {
      if (selectedContacts.contains(contactId)) {
        selectedContacts.remove(contactId);
      } else {
        selectedContacts.add(contactId);
      }

      if (searchBarVisible) {
        searchBarVisible = false;
      }
    });
  }

  _showSearchBar() {
    setState(() {
      searchBarVisible = true;
    });
  }

  _onAppBarBackButtonPressed() {
    if (searchBarVisible) {
      setState(() {
        searchBarVisible = false;
      });
    } else if (selectedContacts.isNotEmpty) {
      setState(() {
        selectedContacts.clear();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatfoeScaffold(
      appBarTitle: selectedContacts.isNotEmpty
          ? selectedContacts.length.toString()
          : 'New chat',
      appBarTitleWidget: searchBarVisible
          ? TextField(
              autofocus: true,
              decoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 40),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  hintText: 'Search contacts',
                  hintStyle: const TextStyle(color: colorNeutral7),
                  prefixIcon: const Icon(
                    FluentIcons.search_24_regular,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.black.withAlpha(16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none)),
            )
          : null,
      appBarActions: selectedContacts.isNotEmpty
          ? [
              ButtonIcon(
                  icon: FluentIcons.more_vertical_24_regular,
                  onPressed: () {},
                  tooltip: 'More'),
            ]
          : !searchBarVisible
              ? [
                  ButtonIcon(
                      icon: FluentIcons.search_24_regular,
                      onPressed: _showSearchBar,
                      tooltip: 'Search'),
                  ButtonIcon(
                      icon: FluentIcons.more_vertical_24_regular,
                      onPressed: () {},
                      tooltip: 'More'),
                ]
              : [],
      onAppBarBackButtonPressed: _onAppBarBackButtonPressed,
      body: ContactList(
          selectedContacts: selectedContacts, selectContact: _selectContact),
      persistentFooterButtons: selectedContacts.isNotEmpty
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFooterButton(context, 'Cancel', () {
                    setState(() {
                      selectedContacts.clear();
                    });
                  }),
                  _buildFooterButton(context, 'Broadcast', () {}),
                  _buildFooterButton(context, 'New group', () {}),
                ],
              ),
            ]
          : null,
    );
  }

  Widget _buildFooterButton(
      BuildContext context, String text, Function() onPressed) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 20) / 3,
      child: TextButton(
          onPressed: onPressed,
          child: Text(text,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
    );
  }
}

class ContactList extends ConsumerStatefulWidget {
  const ContactList(
      {super.key, required this.selectedContacts, required this.selectContact});

  final List<String> selectedContacts;
  final Function(String) selectContact;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactListState();
}

class _ContactListState extends ConsumerState<ContactList> {
  List<String> get selectedContacts => widget.selectedContacts;

  Function(String) get _selectContact => widget.selectContact;

  @override
  void initState() {
    super.initState();
  }

  _onPressed(Contact contact) {
    var handled = false;
    setState(() {
      if (selectedContacts.isNotEmpty) {
        _selectContact(contact.id);
        handled = true;
      }
    });

    if (!handled) {
      // User should be redirected to the empty/all chat screen
      // after navigating from the message screen
      ref
          .read(chatsProvider.notifier)
          .addChat(Chat(id: contact.id, contactId: contact.id));
      setCurrentChat(ref, contact.id);
      Navigator.pushReplacementNamed(context, 'chat/person');
    }
  }

  @override
  Widget build(BuildContext context) {
    final (userIdsInContacts, otherUserIds, contacts) =
        ref.watch(interpolatedUsersAndContactsProvider);

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        final contact = contacts[index];
        return MaterialButton(
            splashColor: Colors.black.withAlpha(13),
            padding: const EdgeInsets.all(0),
            onPressed: () {
              _onPressed(contact);
            },
            onLongPress: () {
              _selectContact(contact.id);
            },
            child: _buildContactItem(
                context, contact, selectedContacts.contains(contact.id)));
      },
    );
  }
}

Widget _buildContactItem(BuildContext context, Contact contact, bool selected) {
  return ListTile(
    contentPadding: const EdgeInsets.fromLTRB(8, 0, 13, 0),
    title: Text(contact.displayName),
    titleTextStyle: TextStyle(
        color: selected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.primary,
        fontSize: 16,
        height: 1),
    subtitle: const Text('Some tagline over here'),
    subtitleTextStyle: TextStyle(
        color: selected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : colorNeutral7,
        fontSize: 15,
        height: 1),
    leading: Avatar(
      radius: 21,
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
  );
}
