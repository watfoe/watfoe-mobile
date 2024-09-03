import 'dart:io';

import 'package:flutter/material.dart';

class WatfoePageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration =>
      Duration(milliseconds: Platform.isAndroid ? 13 : 250);

  WatfoePageRoute({builder, settings})
      : super(builder: builder, settings: settings);
}
