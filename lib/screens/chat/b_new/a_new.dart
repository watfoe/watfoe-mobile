import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:watfoe/components/appbar/screen.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/theme/color_scheme.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<StatefulWidget> createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  List<int> selectedContacts = [];

  _selectContact(int index) {
    setState(() {
      if (selectedContacts.contains(index)) {
        selectedContacts.remove(index);
      } else {
        selectedContacts.add(index);
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
                  TextButton(
                      child: const Text('Broadcast',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {}),
                  TextButton(
                      child: const Text('New community',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {}),
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
    );
  }
}

class ContactList extends StatefulWidget {
  const ContactList(
      {super.key, required this.selectedContacts, required this.selectContact});

  final List<int> selectedContacts;
  final Function(int) selectContact;

  @override
  State<StatefulWidget> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<int> get selectedContacts => widget.selectedContacts;

  Function(int) get _selectContact => widget.selectContact;

  PermissionStatus _permissionStatus = PermissionStatus.denied;
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();

    _fetchContacts();
  }

  _onPressed(int index) {
    var handled = false;
    setState(() {
      if (selectedContacts.isNotEmpty) {
        _selectContact(index);
        handled = true;
      }
    });

    if (!handled) {
      // User should be redirected to the empty/all chat screen
      // after navigating from the message screen

      Navigator.pushReplacementNamed(context, 'chat/inbox/person',
          arguments: _contacts[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return MaterialButton(
            splashColor: Colors.black.withAlpha(13),
            padding: const EdgeInsets.all(0),
            onPressed: () {
              _onPressed(index);
            },
            onLongPress: () {
              _selectContact(index);
            },
            child: _buildContactItem(
                context, _contacts[index], selectedContacts.contains(index)));
      },
    );
  }

  Future<void> _requestPermission() async {
    final status = await Permission.contacts.request();

    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _fetchContacts() async {
    await _requestPermission();
    if (_permissionStatus.isGranted) {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
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
        fontSize: 16),
    subtitle: const Text('Some tagline over here'),
    subtitleTextStyle: TextStyle(
        color: selected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : colorNeutral7,
        fontSize: 15),
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
