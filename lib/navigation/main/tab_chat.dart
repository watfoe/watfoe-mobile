import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/navigation/watfoe_page_route.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/screens/chat/a_chats/a_chats.dart';
import 'package:watfoe/screens/chat/a_empty/empty.dart';
import 'package:watfoe/screens/chat/b_inbox/a_person_inbox.dart';
import 'package:watfoe/screens/chat/b_new/a_new.dart';

class ChatTabNavigator extends ConsumerWidget {
  const ChatTabNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'chat',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'chat':
            builder = (BuildContext context) {
              final chatsLength =
                  ref.watch(chatsProvider.select((chats) => chats.length));

              if (chatsLength == 0) {
                return const EmptyChat();
              }

              return const AllChatsPreview();
            };
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
