import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/theme/color_scheme.dart';

class OtherLocalContactsList extends ConsumerStatefulWidget {
  const OtherLocalContactsList(
      {super.key, required this.contacts, required this.selectContact});

  final List<Contact> contacts;
  final Function(String) selectContact;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OtherLocalContactsListState();
}

class _OtherLocalContactsListState
    extends ConsumerState<OtherLocalContactsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildListItem(context, widget.contacts[index]),
        childCount: widget.contacts.length,
      ),
    );
  }
}

Widget _buildListItem(BuildContext context, Contact contact) {
  return ListTile(
    contentPadding: const EdgeInsets.fromLTRB(8, 0, 13, 0),
    minTileHeight: 68,
    title: Text(
      contact.displayName ?? contact.phones!.first.value!,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 17,
      ),
    ),
    leading: Avatar(
      radius: 21,
    ),
    trailing: const Text(
      'Invite',
      style: TextStyle(
        color: colorPrimary6,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
