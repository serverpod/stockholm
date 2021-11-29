import 'package:flutter/material.dart';

class StockholmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets padding;
  final bool large;

  const StockholmButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4,),
    this.large = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MaterialButton(
      // textTheme: textTheme,
      hoverColor: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: large ? Theme.of(context).textTheme.button! : Theme.of(context).textTheme.bodyText1!,
          child: child,
        ),
      ),
      elevation: 2,
      minWidth: 32,
      padding: EdgeInsets.zero,
    );
  }
}
