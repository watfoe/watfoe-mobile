import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/appbar/tabscreen.dart';
import 'package:watfoe/components/bottom_navigation.dart';

class Sosol extends StatefulWidget {
  const Sosol({super.key});

  @override
  State<Sosol> createState() => _SosolState();
}

class _SosolState extends State<Sosol> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTabscreenAppBar(context, title: 'Sosol'),
      bottomNavigationBar: const BottomNavigation(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Gap(30)],
      ),
    );
  }
}
