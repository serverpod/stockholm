import 'package:flutter/material.dart';

class StockholmListTile extends StatefulWidget {
  final Widget child;
  final bool selected;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;

  const StockholmListTile({
    required this.child,
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
    var content = widget.child;
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

    return MouseRegion(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: widget.selected
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
