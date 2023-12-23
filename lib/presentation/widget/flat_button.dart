import 'package:flutter/material.dart';

import '../styles/colors.dart';

class FlatButton extends StatefulWidget {
  const FlatButton({
    Key? key,
    required this.onPressed,
    this.color,
    this.text,
    this.minWidth,
    this.height,
    this.elevation,
    this.textSize,
    this.radius,
    required this.tOrI,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.iconWidget,
    required this.iconWidgetState,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color? color;
  final String? text;
  final double? minWidth;
  final double? height;
  final double? elevation;
  final double? textSize;
  final double? radius;
  final double? iconSize;
  final bool tOrI;
  final bool iconWidgetState;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;

  @override
  State<FlatButton> createState() => _FlatButtonState();
}

class _FlatButtonState extends State<FlatButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // height: widget.height ?? 55,
      // minWidth: widget.minWidth ?? 80,
      elevation: widget.elevation ?? 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 10)),
      onPressed: () => widget.onPressed(),
      color: widget.color ?? AppColor.defaultColor,
      child: widget.tOrI
          ? Text(
              widget.text ?? '',
              style: TextStyle(
                fontSize: widget.textSize ?? 20.0,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            )
          : widget.iconWidgetState
              ? widget.iconWidget
              : Icon(
                  widget.icon,
                  size: widget.iconSize ?? IconTheme.of(context).size,
                  color: widget.iconColor ?? IconTheme.of(context).color,
                ),
    );
  }
}
