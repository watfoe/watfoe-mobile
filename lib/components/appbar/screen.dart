import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/theme/color_scheme.dart';

PreferredSizeWidget buildScreenAppBar(BuildContext context,
    {String title = '',
    List<Widget>? actions = const <Widget>[],
    String? avatarUrl,
    bool showAvatar = false}) {
  return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leadingWidth: 55,
      toolbarHeight: 55,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: colorPrimary6,
        statusBarIconBrightness: Brightness.dark,
      ),
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          showAvatar
              ? Avatar(
                  url: avatarUrl,
                )
              : const SizedBox(width: 0),
          const Gap(8),
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          )),
        ],
      ),
      actions: actions);
}
