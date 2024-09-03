import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tab {
  const Tab({required this.key, required this.index});

  final GlobalKey<NavigatorState> key;
  final int index;
}

class _BottomNavigationProvider extends StateNotifier<Tab> {
  static final _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // Chat
    GlobalKey<NavigatorState>(), // Pay
    GlobalKey<NavigatorState>(), // Sosol
  ];

  _BottomNavigationProvider() : super(Tab(key: _navigatorKeys[0], index: 0));

  void selectTab(int index) =>
      {state = Tab(key: _navigatorKeys[index], index: index)};
}

final bottomNavigationProvider =
    StateNotifierProvider<_BottomNavigationProvider, Tab>((ref) {
  return _BottomNavigationProvider();
});
