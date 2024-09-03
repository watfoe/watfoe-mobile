import 'package:flutter/material.dart';
import 'package:watfoe/navigation/watfoe.dart';
import 'package:watfoe/screens/sosol/sosol.dart';

class SosolNavigator extends StatelessWidget {
  const SosolNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'sosol',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'sosol':
            builder = (BuildContext context) => const Sosol();
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return WatfoePageRoute(builder: builder, settings: settings);
      },
    );
  }
}
