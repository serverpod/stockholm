import 'package:flutter/material.dart';

class StockholmSideBar extends StatelessWidget {
  const StockholmSideBar({
    required this.children,
    this.width = 240,
    this.backgroundColor,
    this.dividerColor,
    Key? key,
  }) : super(key: key);

  final double width;
  final Color? backgroundColor;
  final Color? dividerColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).backgroundColor,
        border: Border(
          right: BorderSide(
            color: dividerColor ?? Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: children,
      ),
    );
  }
}
