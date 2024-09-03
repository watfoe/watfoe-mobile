import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/theme/color_scheme.dart';

PreferredSizeWidget buildTabscreenAppBar(BuildContext context,
    {String? title,
    List<Widget>? actions = const <Widget>[],
    String? avatarUrl}) {
  return AppBar(
      titleSpacing: 13,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: colorPrimary6,
        statusBarIconBrightness: Brightness.dark,
      ),
      scrolledUnderElevation: 0,
      leadingWidth: 55,
      toolbarHeight: 55,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Avatar(
            url: avatarUrl,
          ),
          const Gap(21),
          title == null
              ? showWatfoeLogo()
              : Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
        ],
      ),
      actions: actions);
}

Widget showWatfoeLogo() {
  return Stack(alignment: Alignment.center, children: [
    Positioned(
      child: SizedBox(
        height: 16,
        child: Image.asset("assets/images/logo.png"),
      ),
    )
  ]);
}
