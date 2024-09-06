import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/components/appbar/screen.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/providers/contacts.dart';
import 'package:watfoe/theme/color_scheme.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<StatefulWidget> createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  List<String> selectedContacts = [];

  _selectContact(String contactId) {
    setState(() {
      if (selectedContacts.contains(contactId)) {
        selectedContacts.remove(contactId);
      } else {
        selectedContacts.add(contactId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildScreenAppBar(context,
          title: selectedContacts.isNotEmpty
              ? selectedContacts.length.toString()
              : 'New chat',
          actions: selectedContacts.isNotEmpty
              ? [
                  ButtonIcon(
                      icon: FluentIcons.more_vertical_24_regular,
                      onPressed: () {},
                      tooltip: 'More'),
                ]
              : [
                  ButtonIcon(
                      icon: FluentIcons.search_24_regular,
                      onPressed: () {},
                      tooltip: 'Search'),
                  ButtonIcon(
                      icon: FluentIcons.more_vertical_24_regular,
                      onPressed: () {},
                      tooltip: 'More'),
                ]),
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
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  Widget _buildFooterButton(
      BuildContext context, String text, Function() onPressed) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(fontWeight: FontWeight.w500))),
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
      Navigator.pushReplacementNamed(context, 'chat/inbox/person',
          arguments: contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactsFut = ref.watch(contactsProvider);

    return contactsFut.when(
        data: (contacts) => ListView.builder(
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
                    child: _buildContactItem(context, contact,
                        selectedContacts.contains(contact.id)));
              },
            ),
        error: (error, _) => Container(),
        loading: () => Container());
  }
}

Widget _buildContactItem(BuildContext context, Contact contact, bool selected) {
  return ListTile(
    contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
      radius: 20,
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
