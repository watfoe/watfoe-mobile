import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/navigation/watfoe_page_route.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/screens/chat/a_chats/s_all_chats_preview.dart';
import 'package:watfoe/screens/chat/a_empty/empty.dart';
import 'package:watfoe/screens/chat/b_inbox/s_conversation_group.dart';
import 'package:watfoe/screens/chat/b_inbox/s_conversation_person.dart';
import 'package:watfoe/screens/chat/s_new_chat.dart';

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
              final chatsLength = ref.watch(chatIdListProvider).length;

              if (chatsLength == 0) {
                return const EmptyChat();
              }

              return const AllChatsPreviewScreen();
            };
          case 'chat/new':
            builder = (BuildContext context) => const NewChatScreen();
          case 'chat/person':
            builder =
                (BuildContext context) => const PersonConversationScreen();
          case 'chat/group':
            builder = (BuildContext context) => const GroupConversationScreen();
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return WatfoePageRoute(builder: builder, settings: settings);
      },
    );
  }
}
