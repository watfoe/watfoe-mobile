import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/navigation/main/tab_chat.dart';
import 'package:watfoe/navigation/main/tab_home.dart';
import 'package:watfoe/navigation/main/tab_pay.dart';
import 'package:watfoe/navigation/main/tab_sosol.dart';
import 'package:watfoe/providers/bottom_navigation.dart';

class MainNavigation extends ConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).colorScheme.surface,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Theme.of(context).colorScheme.surface,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: _buildNavigator(ref)));
  }

  Widget _buildNavigator(WidgetRef ref) {
    final tab = ref.watch(bottomNavigationProvider);

    switch (tab.index) {
      case 0: // Home
        return HomeTabNavigator(navigatorKey: tab.key);
      case 1: // Chat
        return ChatTabNavigator(navigatorKey: tab.key);
      case 2: // Pay
        return PayTabNavigator(navigatorKey: tab.key);
      case 3: // Sosol
        return SosolTabNavigator(navigatorKey: tab.key);
      default:
        return HomeTabNavigator(navigatorKey: tab.key);
    }
  }
}
