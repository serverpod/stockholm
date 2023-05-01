import 'package:flutter/material.dart';

class StockholmListTile extends StatefulWidget {
  final Widget child;
  final Widget? leading;
  final bool selected;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;

  const StockholmListTile({
    required this.child,
    this.leading,
    this.selected = false,
    this.onPressed,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  _StockholmListTileState createState() => _StockholmListTileState();
}

class _StockholmListTileState extends State<StockholmListTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    var isWindows = Theme.of(context).platform == TargetPlatform.windows;

    var content = widget.child;
    if (widget.leading != null) {
      content = Row(
        children: [
          Container(
            height: 16,
            padding: const EdgeInsets.only(right: 8),
            child: IconTheme(
              data: IconThemeData(
                size: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: widget.leading!,
            ),
          ),
          Expanded(child: content),
        ],
      );
    }

    if (widget.onDelete != null) {
      content = Row(
        children: [
          Expanded(child: content),
          _hover
              ? GestureDetector(
                  onTap: widget.onDelete,
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                )
              : const SizedBox(
                  width: 16,
                  height: 16,
                ),
        ],
      );
    }

    var hoverEffect = _hover && isWindows;

    Widget tile = MouseRegion(
      onEnter: (_) {
        setState(() {
          _hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hover = false;
        });
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: isWindows ? const EdgeInsets.symmetric(vertical: 2) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: widget.selected || hoverEffect
                ? BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  )
                : null,
            child: content,
          ),
        ),
      ),
    );

    // Add Windows style selection border
    if (isWindows && widget.selected) {
      tile = Stack(
        fit: StackFit.passthrough,
        children: [
          tile,
          Positioned(
            left: 8,
            top: 8,
            bottom: 8,
            width: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
        ],
      );
    }

    return tile;
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
    var isWindows = Theme.of(context).platform == TargetPlatform.windows;

    var textStyle = isWindows
        ? Theme.of(context).textTheme.titleMedium!
        : Theme.of(context).textTheme.bodySmall!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DefaultTextStyle(
        style: textStyle,
        child: child,
      ),
    );
  }
}
