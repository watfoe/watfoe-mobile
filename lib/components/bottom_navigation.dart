import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/providers/bottom_navigation.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider).index;

    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      onDestinationSelected: (int index) {
        ref.read(bottomNavigationProvider.notifier).selectTab(index);
      },
      indicatorColor: Colors.transparent,
      selectedIndex: selectedIndex,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Icon(FluentIcons.home_24_filled,
              color: Theme.of(context).colorScheme.primary),
          icon: const Icon(FluentIcons.home_24_regular),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Badge(
            label: const Text('9'),
            isLabelVisible: false,
            child: Icon(
              FluentIcons.chat_24_filled,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          icon: const Badge(
            label: Text('9'),
            isLabelVisible: false,
            child: Icon(FluentIcons.chat_24_regular),
          ),
          label: 'Chat',
        ),
        NavigationDestination(
          selectedIcon: Badge(
              isLabelVisible: false,
              child: Icon(
                FluentIcons.wallet_credit_card_24_filled,
                color: Theme.of(context).colorScheme.primary,
              )),
          icon: const Badge(
              isLabelVisible: false,
              child: Icon(FluentIcons.wallet_credit_card_24_regular)),
          label: 'Pay',
        ),
        NavigationDestination(
          selectedIcon: Badge(
            isLabelVisible: false,
            child: Icon(
              FluentIcons.shape_organic_24_filled,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          icon: const Badge(
            isLabelVisible: false,
            child: Icon(FluentIcons.shape_organic_24_regular),
          ),
          label: 'Sosol',
        ),
      ],
    );
  }
}
