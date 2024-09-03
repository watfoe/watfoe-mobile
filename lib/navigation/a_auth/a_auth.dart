import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthNavigation extends StatelessWidget {
  const AuthNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Gap(30)],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
