import 'package:flutter/material.dart';

class StockholmPagination extends StatelessWidget {
  const StockholmPagination({
    this.page = 1,
    this.onNext,
    this.onPrevious,
    this.enabled = true,
    this.large = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    super.key,
  });

  final bool large;
  final EdgeInsets padding;
  final int page;

  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWindows = theme.platform == TargetPlatform.windows;
    var cornerRadius = Radius.circular(isWindows ? 2 : 5);
    var textColor = theme.buttonTheme.colorScheme!.onSurface;
    var textStyle = large
        ? theme.textTheme.labelLarge!.copyWith(color: textColor)
        : theme.textTheme.bodyMedium!.copyWith(color: textColor);

    var borderLeft = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: cornerRadius,
        bottomLeft: cornerRadius,
      ),
    );

    var borderRight = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: cornerRadius,
        bottomRight: cornerRadius,
      ),
    );

    var segments = <Widget>[
      MaterialButton(
        color: theme.buttonTheme.colorScheme!.surface,
        disabledColor: theme.buttonTheme.colorScheme!.surface,
        onPressed: enabled ? onPrevious : null,
        shape: borderLeft,
        elevation: 0,
        padding: EdgeInsets.zero,
        minWidth: large ? 44 : 42,
        child: Container(
          alignment: Alignment.center,
          height: large ? 30 : 22,
          child: DefaultTextStyle(
            style: large
                ? theme.textTheme.labelLarge!.copyWith(color: textColor)
                : theme.textTheme.bodyMedium!.copyWith(color: textColor),
            child: Icon(
              Icons.chevron_left,
              size: large ? 24 : 20,
            ),
          ),
        ),
      ),
      Container(
        color: theme.buttonTheme.colorScheme!.surface,
        height: large ? 30 : 28,
        padding: padding,
        margin: const EdgeInsets.symmetric(
          horizontal: 1,
        ),
        child: Center(
          child: Text('Page $page'),
        ),
      ),
      MaterialButton(
        color: theme.buttonTheme.colorScheme!.surface,
        disabledColor: theme.buttonTheme.colorScheme!.surface,
        onPressed: enabled ? onNext : null,
        shape: borderRight,
        elevation: 0,
        padding: EdgeInsets.zero,
        minWidth: large ? 50 : 42,
        child: Container(
          alignment: Alignment.center,
          height: large ? 30 : 22,
          padding: EdgeInsets.zero,
          child: DefaultTextStyle(
            style: large
                ? theme.textTheme.labelLarge!.copyWith(color: textColor)
                : theme.textTheme.bodyMedium!.copyWith(color: textColor),
            child: Icon(
              Icons.chevron_right,
              size: large ? 24 : 20,
            ),
          ),
        ),
      ),
    ];

    return DefaultTextStyle(
      style: textStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: theme.dividerColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(isWindows ? 3 : 6),
              ),
            ),
            elevation: 2,
            shadowColor: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: segments,
              ),
            ),
          )
        ],
      ),
    );
  }
}
