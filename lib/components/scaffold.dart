import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:watfoe/components/avatar.dart';
import 'package:watfoe/components/bottom_navigation.dart';
import 'package:watfoe/components/button/button.dart';
import 'package:watfoe/theme/color_scheme.dart';

class WatfoeScaffold extends StatefulWidget {
  const WatfoeScaffold(
      {super.key,
      required this.body,
      this.appBarTitle,
      this.appBarTitleStyle,
      this.appBarTitleWidget,
      this.centerTitle = false,
      this.appBarActions = const <Widget>[],
      this.appBarAvatarUrl,
      this.showAppBarAvatar = false,
      this.showBottomNavigationBar = false,
      this.floatingActionButton,
      this.persistentFooterButtons});

  final Widget body;
  final String? appBarTitle;
  final Widget? appBarTitleWidget;
  final TextStyle? appBarTitleStyle;
  final bool centerTitle;
  final List<Widget>? appBarActions;
  final String? appBarAvatarUrl;
  final bool showAppBarAvatar;
  final bool showBottomNavigationBar;
  final Widget? floatingActionButton;
  final List<Widget>? persistentFooterButtons;

  @override
  State<StatefulWidget> createState() => _WatfoeScaffold();
}

class _WatfoeScaffold extends State<WatfoeScaffold> {
  TextStyle get appBarTitleStyle =>
      widget.appBarTitleStyle ??
      const TextStyle(
        color: colorPrimary6,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      );

  String? get appBarAvatarUrl => widget.appBarAvatarUrl;

  bool get showAppBarAvatar => widget.showAppBarAvatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(child: widget.body),
      bottomNavigationBar:
          widget.showBottomNavigationBar ? const BottomNavigation() : null,
      floatingActionButton: widget.floatingActionButton,
      persistentFooterButtons: widget.persistentFooterButtons,
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
        titleSpacing: 13,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leadingWidth: canPop
            ? _hasAvatar()
                ? 85
                : 51
            : _hasAvatar()
                ? 48
                : 0,
        leading: _buildLeading(context),
        toolbarHeight: 60,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: colorPrimary6,
          statusBarIconBrightness: Brightness.dark,
        ),
        scrolledUnderElevation: 0,
        title: _title(),
        centerTitle: widget.centerTitle,
        actions: widget.appBarActions);
  }

  Widget _backButton(BuildContext context) {
    return ButtonIcon(
        icon: Platform.isAndroid
            ? FluentIcons.arrow_left_24_regular
            : Symbols.arrow_back_ios_new_rounded,
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  Widget _avatar(BuildContext context) {
    if (!showAppBarAvatar && appBarAvatarUrl == null) {
      return Container();
    }

    return Avatar(
      radius: 17,
      url: appBarAvatarUrl,
    );
  }

  bool _hasAvatar() {
    return appBarAvatarUrl != null || showAppBarAvatar;
  }

  Widget? _buildLeading(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    if (canPop) {
      if (appBarAvatarUrl != null || showAppBarAvatar) {
        return Row(
          children: [
            _backButton(context),
            _avatar(context),
          ],
        );
      } else {
        return Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 3),
              child: _backButton(context))
        ]);
      }
    } else {
      if (appBarAvatarUrl != null || showAppBarAvatar) {
        return Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 13), child: _avatar(context))
        ]);
      }
    }

    return null;
  }

  Widget? _title() {
    if (widget.appBarTitleWidget != null) {
      return widget.appBarTitleWidget!;
    }

    if (widget.appBarTitle != null) {
      return Expanded(
          child: Text(
        widget.appBarTitle!,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ));
    }

    return null;
  }
}