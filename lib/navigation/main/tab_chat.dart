import 'package:flutter/material.dart';
import 'package:watfoe/navigation/watfoe_page_route.dart';
import 'package:watfoe/screens/chat/a_chats/a_chats.dart';
import 'package:watfoe/screens/chat/a_empty/empty.dart';
import 'package:watfoe/screens/chat/b_inbox/a_person_inbox.dart';
import 'package:watfoe/screens/chat/b_new/a_new.dart';

class ChatTabNavigator extends StatelessWidget {
  const ChatTabNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'chat/empty',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'chat':
            builder = (BuildContext context) => const Chat();
          case 'chat/empty':
            builder = (BuildContext context) => const EmptyChat();
          case 'chat/new':
            builder = (BuildContext context) => const NewChat();
          case 'chat/inbox/person':
            builder = (BuildContext context) => const PersonInbox();
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return WatfoePageRoute(builder: builder, settings: settings);
      },
    );
  }
}
