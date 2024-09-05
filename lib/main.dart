import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/navigation/auth/auth.dart';
import 'package:watfoe/navigation/main/main.dart';
import 'package:watfoe/theme/color_scheme.dart';
import 'package:watfoe/theme/icon.dart';

void main() {
  runApp(const ProviderScope(child: WatfoeApp()));
}

class WatfoeApp extends StatelessWidget {
  const WatfoeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watfoe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        fontFamily: Platform.isAndroid ? 'OneUi' : null,
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
      home: const MainNavigation(),
      routes: <String, WidgetBuilder>{
        '/auth': (BuildContext context) => const AuthNavigation(),
        '/main': (BuildContext context) => const MainNavigation(),
      },
    );
  }
}
