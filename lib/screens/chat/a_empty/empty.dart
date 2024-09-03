import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/appbar/tabscreen.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/navigation/a_main/b_bottom_navigation.dart';

class EmptyChat extends StatelessWidget {
  const EmptyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTabscreenAppBar(context, title: "", actions: [
        RotatedBox(
            quarterTurns: -1,
            child: ButtonIcon(
              icon: FluentIcons.call_end_24_regular,
              onPressed: () {},
              tooltip: 'Calls',
            )),
        ButtonIcon(
          icon: FluentIcons.more_vertical_24_regular,
          onPressed: () {},
          tooltip: 'More chat options',
        ),
      ]),
      bottomNavigationBar: const BottomNavigation(),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 74),
              const Gap(21),
              const Text(
                "Chat",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(89),
              FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'chat/new');
                },
                child: const Text("Start a new chat"),
              )
            ],
          )),
    );
  }
}
