import 'package:flutter/material.dart';

class StockholmToolbar extends StatelessWidget {
  const StockholmToolbar({
    required this.children,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }
}

class StockholmToolbarButton extends StatelessWidget {
  final double? width;
  final String? label;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;
  final bool selected;

  StockholmToolbarButton({
    required this.icon,
    required this.onPressed,
    this.label,
    this.width,
    this.color,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget button;

    button = Icon(
      icon,
      color: color ?? Theme.of(context).iconTheme.color,
      size: 16.0,
    );

    if (label != null) {
      button = Row(
        children: [
          button,
          Padding(
            padding: EdgeInsets.only(left: 6.0),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      );
    }

    return MaterialButton(
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      highlightColor: null,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      color: selected ? Theme.of(context).highlightColor : null,
      minWidth: 32,
      hoverColor: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Container(
        height: 24,
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: button,
      ),
    );
  }
}

class StockholmToolbarDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      child: VerticalDivider(
        width: 8.0,
        thickness: 1.0,
      ),
    );
  }
}
