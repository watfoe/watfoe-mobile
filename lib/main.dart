import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/navigation/a_auth/a_auth.dart';
import 'package:watfoe/navigation/a_main/a_main.dart';
import 'package:watfoe/screens/welcome.dart';
import 'package:watfoe/theme/color_scheme.dart';
import 'package:watfoe/theme/icon.dart';

void main() {
  runApp(ProviderScope(child: const WatfoeApp()));
}

class WatfoeApp extends StatelessWidget {
  const WatfoeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watfoe',
      theme: ThemeData(
        colorScheme: colorScheme,
        fontFamily: null,
        iconTheme: iconTheme,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        typography: Typography.material2021(),
        useMaterial3: true,
      ),
      home: const Welcome(),
      routes: <String, WidgetBuilder>{
        '/auth': (BuildContext context) => const AuthNavigation(),
        '/main': (BuildContext context) => const MainNavigation(),
      },
    );
  }
}
