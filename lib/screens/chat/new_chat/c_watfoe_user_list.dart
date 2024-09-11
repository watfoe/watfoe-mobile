import 'package:flutter/material.dart';
import 'package:watfoe/screens/chat/new_chat/c_user_list_item.dart';

class WatfoeUserList extends StatefulWidget {
  const WatfoeUserList(
      {super.key,
      required this.userIds,
      required this.selectedContacts,
      required this.selectContact});

  final List<String> userIds;
  final List<String> selectedContacts;
  final Function(String) selectContact;

  @override
  State<StatefulWidget> createState() => _WatfoeUserListState();
}

class _WatfoeUserListState extends State<WatfoeUserList> {
  List<String> get selectedContacts => widget.selectedContacts;

  Function(String) get _selectContact => widget.selectContact;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return UserListItem(
              userId: widget.userIds[index],
              selectedContacts: selectedContacts,
              selectContact: _selectContact);
        },
        childCount: widget.userIds.length,
      ),
    );
  }
}
