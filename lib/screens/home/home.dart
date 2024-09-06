import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:watfoe/components/scaffold.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WatfoeScaffold(
      appBarAvatarUrl: "https://cdn.watfoe.com/i/watfoe-logo.png",
      appBarTitleWidget: _watfoeLogo(),
      centerTitle: true,
      appBarActions: [
        IconButton(
          icon: const Icon(FluentIcons.more_vertical_24_regular),
          onPressed: () {},
          tooltip: 'More options',
        ),
      ],
      showBottomNavigationBar: true,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }

  Widget _watfoeLogo() {
    return Stack(alignment: Alignment.center, children: [
      Positioned(
        child: SizedBox(
          height: 18,
          child: Image.asset("assets/images/logo.png"),
        ),
      )
    ]);
  }
}
