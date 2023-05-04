import 'package:flutter/material.dart';

class StockholmSegmentedControl extends StatelessWidget {
  const StockholmSegmentedControl({
    required this.children,
    required this.selected,
    required this.onSelected,
    this.large = false,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final int selected;
  final void Function(int index) onSelected;
  final bool large;
  final bool enabled;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWindows = theme.platform == TargetPlatform.windows;

    final segments = <Widget>[];
    for (var i = 0; i < children.length; i += 1) {
      Color textColor;
      if (enabled) {
        if (selected == i) {
          textColor = theme.buttonTheme.colorScheme!.onPrimary;
        } else {
          textColor = theme.buttonTheme.colorScheme!.onSurface;
        }
      } else {
        textColor = theme.disabledColor;
      }

      var cornerRadius = Radius.circular(isWindows ? 2 : 5);

      RoundedRectangleBorder border;
      if (i == 0) {
        border = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: cornerRadius,
            bottomLeft: cornerRadius,
          ),
        );
      } else if (i == children.length - 1) {
        border = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: cornerRadius,
            bottomRight: cornerRadius,
          ),
        );
      } else {
        border = const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(),
        );
      }

      segments.add(
        MaterialButton(
          color: i == selected
              ? theme.colorScheme.primary
              : theme.buttonTheme.colorScheme!.surface,
          hoverColor: Theme.of(context).hoverColor,
          shape: border,
          onPressed: enabled
              ? () {
                  onSelected(i);
                }
              : null,
          child: Container(
            alignment: Alignment.center,
            height: large ? 30 : 22,
            padding: padding,
            child: DefaultTextStyle(
              style: large
                  ? theme.textTheme.labelLarge!.copyWith(color: textColor)
                  : theme.textTheme.bodyMedium!.copyWith(color: textColor),
              child: children[i],
            ),
          ),
          elevation: 0,
          minWidth: 32,
          padding: EdgeInsets.zero,
        ),
      );
      segments.add(Container(
        width: 1.0,
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Theme.of(context).dividerColor,
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
    );
  }
}
