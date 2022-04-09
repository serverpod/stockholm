import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

class StockholmContextMenu extends StatelessWidget {
  const StockholmContextMenu({
    required this.child,
    required this.menu,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final StockholmMenu menu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // behavior: HitTestBehavior.opaque,
      onSecondaryTapDown: (details) {
        var anchor = details.globalPosition;
        showStockholmMenu(
          context: context,
          preferredAnchorPoint: anchor,
          menu: menu,
        );
      },
      child: child,
    );
  }
}
