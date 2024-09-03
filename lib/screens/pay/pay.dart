import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/appbar/tabscreen.dart';
import 'package:watfoe/navigation/a_main/b_bottom_navigation.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTabscreenAppBar(context, title: 'Pay', actions: [
        IconButton(
          icon: const Icon(FluentIcons.add_24_regular),
          onPressed: () {},
        ),
      ]),
      bottomNavigationBar: const BottomNavigation(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Gap(30)],
      ),
    );
  }
}
