import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  IconData icon;
  Function? onPressed;
  Color? bgcolor;
  Color? fgcolor;
  double? size;
  String? tooltip;

  ButtonIcon(
      {required this.icon,
      required this.onPressed,
      this.bgcolor,
      this.fgcolor,
      this.size,
      this.tooltip});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed as void Function()?,
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor:
              bgcolor != null ? WidgetStateProperty.all<Color>(bgcolor!) : null,
          foregroundColor:
              fgcolor != null ? WidgetStateProperty.all<Color>(fgcolor!) : null,
        ),
        tooltip: tooltip ?? null,
        icon: Icon(icon));
  }
}
