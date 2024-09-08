import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/models/message.dart';
import 'package:watfoe/providers/chat/chats.dart';
import 'package:watfoe/screens/chat/b_inbox/message_bubble.dart';

class MessagesArea extends ConsumerStatefulWidget {
  const MessagesArea({super.key, required this.chatId});

  final String chatId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagesAreaState();
}

class _MessagesAreaState extends ConsumerState<MessagesArea> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  List<Message> _messages = [];
  bool _autoScroll = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // User has scrolled to the top
        setState(() {
          _autoScroll = false;
        });
      } else {
        // User has scrolled to the bottom
        setState(() {
          _autoScroll = true;
        });
      }
    }
  }

  void _scrollToBottom() {
    if (_autoScroll) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final newMessages = ref.watch(
            chatProvider(widget.chatId).select((chat) => chat?.messages)) ??
        [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateList(newMessages);
      _scrollToBottom();
    });

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          reverse: true,
          slivers: [
            SliverAnimatedList(
              key: _listKey,
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                return _buildAnimatedItem(
                    _messages[_messages.length - 1 - index], animation);
              },
            ),
          ],
        ),
        if (!_autoScroll)
          _buildScrollToBottomButton(_autoScroll, _scrollToBottom),
      ],
    );
  }

  Widget _buildAnimatedItem(Message message, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(Tween(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic))),
      child: FadeTransition(
        opacity: animation,
        child: MessageBubble(message: message),
      ),
    );
  }

  void _updateList(List<Message> newMessages) {
    final oldMessages = List<Message>.from(_messages);
    _messages = List<Message>.from(newMessages);

    // Handle removals
    for (var i = oldMessages.length - 1; i >= 0; i--) {
      if (!_messages.contains(oldMessages[i])) {
        final removedMessage = oldMessages[i];
        _listKey.currentState?.removeItem(
          oldMessages.length - 1 - i,
          (context, animation) => _buildAnimatedItem(
              removedMessage, animation.drive(Tween(begin: 1.0, end: 0.0))),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    if (oldMessages.isEmpty) {
      _listKey.currentState?.insertAllItems(0, _messages.length,
          duration: const Duration(milliseconds: 300));
    } else {
      // Handle inserts
      for (var i = 0; i < _messages.length; i++) {
        if (!oldMessages.contains(_messages[i])) {
          _listKey.currentState?.insertItem(
            _messages.length - 1 - i,
            duration: const Duration(milliseconds: 300),
          );
        }
      }
    }
  }
}

Widget _buildScrollToBottomButton(bool autoScroll, Function() onPressed) {
  return Positioned(
    bottom: 13,
    left: 0,
    right: 0,
    child: FloatingActionButton(
      mini: true,
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: const Icon(
        FluentIcons.arrow_down_24_regular,
        size: 20,
      ),
    ),
  );
}
