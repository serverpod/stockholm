import 'package:flutter/material.dart';

class StockholmSideBar extends StatelessWidget {
  const StockholmSideBar({
    required this.children,
    this.width = 240,
    this.padding,
    this.backgroundColor,
    this.dividerColor,
    this.footer,
    Key? key,
  }) : super(key: key);

  final double width;
  final Color? backgroundColor;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.background,
        border: Border(
          right: BorderSide(
            color: dividerColor ?? Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: children,
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
