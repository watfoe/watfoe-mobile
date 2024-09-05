import 'package:flutter/material.dart';
import 'package:watfoe/models/message.dart';
import 'package:watfoe/screens/chat/b_inbox/message_container.dart';

class MessagesArea extends StatefulWidget {
  const MessagesArea({super.key});

  @override
  State<StatefulWidget> createState() => _MessagesAreaState();
}

class _MessagesAreaState extends State<MessagesArea> {
  List<int> selectedMessages = [];

  Function(int) _selectMessage = (int index) {};

  List<Map<String, dynamic>> _messages = [
    {
      "id": "1",
      "text":
          "Did you see the latest data from the Mars rover? The soil samples are revealing something interesting.",
      "createdAt": "2023-08-10T09:00:00Z",
      "state": "read",
      "type": "outgoing"
    },
    {
      "id": "2",
      "text":
          "Yes, the mineral composition suggests water might have been present. It's a significant finding.",
      "createdAt": "2023-08-10T09:02:15Z",
      "state": "read",
      "type": "incoming"
    },
    {
      "id": "3",
      "text":
          "Absolutely. I’m curious about the next set of images from the crater’s edge.",
      "createdAt": "2023-08-10T09:05:30Z",
      "state": "read",
      "type": "outgoing"
    },
    {
      "id": "4",
      "text":
          "Same here. They might give us clues about the planet’s geological history.",
      "createdAt": "2023-08-10T09:07:50Z",
      "state": "read",
      "type": "incoming"
    },
    {
      "id": "5",
      "text":
          "By the way, did you check the link I sent earlier on the recent asteroid mission? It’s fascinating!",
      "createdAt": "2023-08-10T09:10:05Z",
      "state": "read",
      "type": "outgoing",
      "attachment": {
        "type": "link",
        "link":
            "https://education.nationalgeographic.org/resource/history-space-exploration/"
      },
    },
    {
      "id": "6",
      "text":
          "Yes, I did. The asteroid composition could reveal the building blocks of the early solar system.",
      "createdAt": "2023-08-10T09:12:30Z",
      "state": "read",
      "type": "incoming"
    },
    {
      "id": "7",
      "text":
          "Exactly! These findings might even change our understanding of how planets formed.",
      "createdAt": "2023-08-10T09:15:00Z",
      "state": "read",
      "type": "outgoing"
    },
    {
      "id": "8",
      "text":
          "I just realized I made an error in my previous message. The asteroid might be a remnant of a protoplanet, not just building blocks.",
      "createdAt": "2023-08-10T09:17:45Z",
      "state": "read",
      "type": "incoming",
      "meta": {"isEdited": true}
    },
    {
      "id": "9",
      "text":
          "No worries, it’s a complex topic. The idea of protoplanets is intriguing—imagine the stories they could tell!",
      "createdAt": "2023-08-10T09:20:10Z",
      "state": "read",
      "type": "outgoing"
    },
    {
      "id": "10",
      "text":
          "Indeed! We’re just scratching the surface of what’s out there. The universe is full of surprises.",
      "createdAt": "2023-08-10T09:23:00Z",
      "state": "read",
      "type": "incoming"
    },
    {
      "id": "11",
      "text": "That, is wonderful",
      "createdAt": "2023-08-10T09:27:00Z",
      "state": "read",
      "type": "outgoing"
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  _onPressed(int index) {
    var handled = false;
    setState(() {
      if (selectedMessages.isNotEmpty) {
        _selectMessage(index);
        handled = true;
      }
    });

    if (!handled) {
      // User should be redirected to the empty/all chat screen
      // after navigating from the message screen

      Navigator.pushReplacementNamed(context, 'chat/inbox/person',
          arguments: _messages[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _messages.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        final message = Message.fromJson(_messages[index]);

        return MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
            onLongPress: () {
              _selectMessage(index);
            },
            child: MessageContainer(message: message));
      },
    );
  }
}
