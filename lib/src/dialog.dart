import 'package:flutter/material.dart';

class StockholmDialog extends StatelessWidget {
  final Widget title;
  final Widget contents;
  final double width;
  final List<Widget>? actionButtons;

  const StockholmDialog({
    required this.title,
    required this.contents,
    this.actionButtons,
    this.width = 500,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var actionButtonWidgets = <Widget>[];
    if (actionButtons != null) {
      var first = true;
      for (var button in actionButtons!) {
        if (!first)
          actionButtonWidgets.add(SizedBox(width: 8,));
        actionButtonWidgets.add(button);
        first = false;
      }
    }

    return Dialog(
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              height: 28,
              child: Center(
                child: DefaultTextStyle(
                  style: theme.textTheme.subtitle1!,
                  child: title,
                ),
              ),
            ),
            Container(
              color: theme.dividerColor,
              height: 1,
            ),
            contents,
            if (actionButtons != null) Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actionButtonWidgets,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
