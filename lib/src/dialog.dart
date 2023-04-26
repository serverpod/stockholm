import 'package:flutter/material.dart';
import 'package:stockholm/src/button.dart';

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
    var isWindows = theme.platform == TargetPlatform.windows;

    var actionButtonWidgets = <Widget>[];
    if (actionButtons != null) {
      var first = true;
      for (var button in actionButtons!) {
        if (!first) {
          actionButtonWidgets.add(const SizedBox(
            width: 8,
          ));
        }
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
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(isWindows ? 8 : 12),
                ),
              ),
              height: isWindows ? 42 : 28,
              child: Container(
                alignment: isWindows ? Alignment.centerLeft : Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: isWindows ? 16 : 0,
                ),
                child: DefaultTextStyle(
                  style: isWindows
                      ? theme.textTheme.titleLarge!
                      : theme.textTheme.titleMedium!,
                  child: title,
                ),
              ),
            ),
            Container(
              color: theme.dividerColor,
              height: 1,
            ),
            contents,
            if (isWindows)
              Container(
                color: theme.dividerColor,
                height: 1,
              ),
            if (actionButtons != null)
              Container(
                decoration: isWindows
                    ? BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(8),
                        ),
                      )
                    : null,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
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

class StockholmConfirmationDialog extends StatelessWidget {
  final ValueChanged<bool> onSelection;
  final Widget title;
  final Widget primaryOptionTitle;
  final Widget secondaryOptionTitle;
  final Widget contents;

  const StockholmConfirmationDialog({
    required this.onSelection,
    required this.title,
    required this.primaryOptionTitle,
    required this.secondaryOptionTitle,
    required this.contents,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StockholmDialog(
      width: 300,
      title: title,
      contents: Padding(
        padding: const EdgeInsets.all(16),
        child: contents,
      ),
      actionButtons: [
        StockholmButton(
          onPressed: () {
            Navigator.of(context).pop();
            onSelection(false);
          },
          child: secondaryOptionTitle,
        ),
        StockholmButton(
          important: true,
          onPressed: () {
            Navigator.of(context).pop();
            onSelection(true);
          },
          child: primaryOptionTitle,
        ),
      ],
    );
  }
}

void showStockholmConfirmationDialog({
  required BuildContext context,
  required ValueChanged<bool> onSelection,
  required Widget title,
  required Widget contents,
  Widget primaryOptionTitle = const Text('OK'),
  Widget secondaryOptionTitle = const Text('Cancel'),
}) {
  showDialog(
    context: context,
    builder: (context) {
      return StockholmConfirmationDialog(
        onSelection: onSelection,
        title: title,
        contents: contents,
        primaryOptionTitle: primaryOptionTitle,
        secondaryOptionTitle: secondaryOptionTitle,
      );
    },
  );
}
