import 'package:flutter/material.dart';
import 'package:watfoe/navigation/watfoe.dart';
import 'package:watfoe/screens/pay/pay.dart';

class PayNavigator extends StatelessWidget {
  const PayNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'pay',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'pay':
            builder = (BuildContext context) => const Pay();
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return WatfoePageRoute(builder: builder, settings: settings);
      },
    );
  }
}