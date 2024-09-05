import 'package:flutter/material.dart';
import 'package:watfoe/navigation/watfoe_page_route.dart';
import 'package:watfoe/screens/home/home.dart';

class HomeTabNavigator extends StatelessWidget {
  const HomeTabNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => const Home();
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return WatfoePageRoute(builder: builder, settings: settings);
      },
    );
  }
}
