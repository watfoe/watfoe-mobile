import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/components/scaffold.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return WatfoeScaffold(
      appBarAvatarUrl: "https://cdn.watfoe.com/i/watfoe-logo.png",
      appBarTitle: 'Pay',
      appBarActions: [
        ButtonIcon(
          icon: FluentIcons.more_vertical_24_regular,
          onPressed: () {},
          tooltip: 'More pay options',
        ),
      ],
      showBottomNavigationBar: true,
      body: Container(),
    );
  }
}
