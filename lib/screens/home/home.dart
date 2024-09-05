import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:watfoe/components/appbar/tabscreen.dart';
import 'package:watfoe/components/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTabscreenAppBar(context,
          avatarUrl: "https://cdn.watfoe.com/i/watfoe-logo.png",
          actions: [
            IconButton(
              icon: const Icon(FluentIcons.more_vertical_24_regular),
              onPressed: () {},
              tooltip: 'More options',
            ),
          ]),
      bottomNavigationBar: const BottomNavigation(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
