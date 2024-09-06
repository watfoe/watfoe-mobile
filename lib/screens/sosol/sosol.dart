import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';

class Sosol extends StatelessWidget {
  const Sosol({super.key});

  @override
  Widget build(BuildContext context) {
    return WatfoeScaffold(
      appBarAvatarUrl: "https://cdn.watfoe.com/i/watfoe-logo.png",
      appBarTitle: 'Sosol',
      appBarActions: [
        ButtonIcon(
          icon: FluentIcons.more_vertical_24_regular,
          onPressed: () {},
          tooltip: 'More sosol options',
        ),
      ],
      showBottomNavigationBar: true,
      body: Container(),
    );
  }
}
