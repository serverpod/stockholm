import 'package:flutter/material.dart';

class StockholmSideBar extends StatelessWidget {
  const StockholmSideBar({
    required this.children,
    this.width = 240,
    this.padding,
    this.backgroundColor,
    this.dividerColor,
    this.footer,
    this.selectedIndex,
    this.onDestinationSelected,
    Key? key,
  }) : super(key: key);

  final double width;
  final Color? backgroundColor;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;
  final Widget? footer;

  /// The index of the currently selected destination, or null if no destination
  /// is selected.
  final int? selectedIndex;

  /// Called when one of the destinations is selected.
  ///
  /// The stateful widget that creates this widget needs to call [setState] when
  /// this callback is called in order to rebuild the sidebar with the new
  /// [selectedIndex].
  ///
  /// If a child widget also handles tap events (e.g. via [StockholmListTile]'s
  /// [onPressed]), both callbacks will fire when the child is tapped.
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    List<Widget> resolvedChildren;
    if (onDestinationSelected != null) {
      resolvedChildren = [
        for (var i = 0; i < children.length; i++)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onDestinationSelected!(i),
            child: children[i],
          ),
      ];
    } else {
      resolvedChildren = children;
    }

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
              children: resolvedChildren,
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
