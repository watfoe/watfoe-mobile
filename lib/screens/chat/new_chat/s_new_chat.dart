import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';
import 'package:watfoe/providers/users.dart';
import 'package:watfoe/screens/chat/new_chat/c_other_local_contacts_list.dart';
import 'package:watfoe/screens/chat/new_chat/c_watfoe_user_list.dart';
import 'package:watfoe/theme/color_scheme.dart';

class NewChatScreen extends ConsumerStatefulWidget {
  const NewChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewChatScreen();
}

class _NewChatScreen extends ConsumerState<NewChatScreen> {
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
    final (contactUserIdsInWatfoe, userIds, contactToInvite) =
        ref.watch(interpolatedUsersAndContactsProvider);

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
      body: CustomScrollView(
        slivers: [
          if (contactUserIdsInWatfoe.isNotEmpty)
            _buildTitle(context, 'Contacts in Watfoe'),
          WatfoeUserList(
              userIds: contactUserIdsInWatfoe,
              selectedContacts: selectedContacts,
              selectContact: _selectContact),
          if (userIds.isNotEmpty)
            _buildTitle(context, 'Friends from Sosol', topPadding: 13),
          WatfoeUserList(
            userIds: userIds,
            selectedContacts: selectedContacts,
            selectContact: _selectContact,
          ),
          if (contactToInvite.isNotEmpty)
            _buildTitle(context, 'Invite to Watfoe', topPadding: 13),
          OtherLocalContactsList(
            contacts: contactToInvite,
            selectContact: _selectContact,
          )
        ],
      ),
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

  Widget _buildTitle(BuildContext context, String title,
      {double topPadding = 0}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 13, top: topPadding),
        child: Text(title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            )),
      ),
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
