import 'package:flutter/material.dart';

class StockholmListTile extends StatelessWidget {
  final Widget child;
  final bool selected;
  final VoidCallback? onPressed;

  const StockholmListTile({
    required this.child,
    this.selected = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: selected
              ? BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                )
              : null,
          child: child,
        ),
      ),
    );
  }
}

class StockholmListTileHeader extends StatelessWidget {
  final Widget child;

  const StockholmListTileHeader({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.caption!,
        child: child,
      ),
    );
  }
}
