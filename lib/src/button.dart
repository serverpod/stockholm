import 'package:flutter/material.dart';

class StockholmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets padding;
  final bool large;
  final bool important;

  const StockholmButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4,),
    this.large = false,
    this.important = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = important ? theme.buttonTheme.colorScheme!.onPrimary : theme.buttonTheme.colorScheme!.onSurface;

    return MaterialButton(
      // textTheme: textTheme,
      color: important ? theme.colorScheme.primary : theme.buttonTheme.colorScheme!.surface,
      hoverColor: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: large ? theme.textTheme.button!.copyWith(color: textColor) : theme.textTheme.bodyText2!.copyWith(color: textColor),
          child: child,
        ),
      ),
      elevation: 2,
      minWidth: 32,
      padding: EdgeInsets.zero,
    );
  }
}
