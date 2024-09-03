import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/components/drawer/main_drawer.dart';
import 'package:watfoe/navigation/a_main/c_chat.dart';
import 'package:watfoe/navigation/a_main/c_home.dart';
import 'package:watfoe/navigation/a_main/c_pay.dart';
import 'package:watfoe/navigation/a_main/c_sosol.dart';
import 'package:watfoe/providers/bottom_navigation.dart';

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(bottomNavigationProvider);

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          var canPop = tab.key.currentState?.canPop() ?? false;
          if (canPop) {
            tab.key.currentState?.pop(result);
          } else if (tab.index > 0) {
            ref.read(bottomNavigationProvider.notifier).selectTab(0);
          } else if (Platform.isAndroid) {
            // Only for Android because of the back button
            // rootNavigator.pop();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: _buildNavigator(),
          ),
          drawer: mainDrawer(context),
        ));
  }

  Widget _buildNavigator() {
    final tab = ref.watch(bottomNavigationProvider);

    switch (tab.index) {
      case 0: // Home
        return HomeNavigator(navigatorKey: tab.key);
      case 1: // Chat
        return ChatNavigator(navigatorKey: tab.key);
      case 2: // Pay
        return PayNavigator(navigatorKey: tab.key);
      case 3: // Sosol
        return SosolNavigator(navigatorKey: tab.key);
      default:
        return HomeNavigator(navigatorKey: tab.key);
    }
  }
}
