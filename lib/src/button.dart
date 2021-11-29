import 'package:flutter/material.dart';

class StockholmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const StockholmButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      hoverColor: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
      ),
      onPressed: onPressed,
      child: child,
      elevation: 2,
      minWidth: 32,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
