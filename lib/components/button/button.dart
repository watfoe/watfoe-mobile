import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.bgcolor,
      this.fgcolor,
      this.size,
      this.tooltip});

  final IconData icon;
  final Function? onPressed;
  final Color? bgcolor;
  final Color? fgcolor;
  final double? size;
  final String? tooltip;

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
        tooltip: tooltip,
        icon: Icon(
          icon,
          size: size,
        ));
  }
}
