import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.appBarWidget})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);
  final Widget appBarWidget;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: appBarWidget,
    );
  }
}