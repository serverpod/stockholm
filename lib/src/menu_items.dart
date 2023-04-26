import 'dart:async';

import 'package:flutter/material.dart';

const _menuItemHeight = 24.0;
const _menuDividerHeight = 10.0;
const _menuPadding = EdgeInsets.all(4);
const _menuPaddingWindows = EdgeInsets.symmetric(vertical: 4);

class StockholmMenu extends StatelessWidget {
  const StockholmMenu({
    required this.items,
    this.width,
    Key? key,
  }) : super(key: key);

  final List<StockholmMenuEntity> items;
  final double? width;

  double get height =>
      items.fold(_menuPadding.vertical * 2, (prev, e) => prev + e.height);

  @override
  Widget build(BuildContext context) {
    var isWindows = Theme.of(context).platform == TargetPlatform.windows;

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).popupMenuTheme.color,
          borderRadius: BorderRadius.all(Radius.circular(isWindows ? 3 : 8)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 16,
              offset: Offset(0, 4),
            )
          ],
          border: Border.all(color: Theme.of(context).dividerColor)),
      padding: isWindows ? _menuPaddingWindows : _menuPadding,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items,
        ),
      ),
    );
  }
}

abstract class StockholmMenuEntity extends Widget {
  const StockholmMenuEntity({Key? key}) : super(key: key);

  double get height;
}

class StockholmMenuItem extends StatefulWidget implements StockholmMenuEntity {
  const StockholmMenuItem({
    required this.child,
    this.onSelected,
    this.height = _menuItemHeight,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onSelected;

  @override
  final double height;

  @override
  _StockholmMenuItemState createState() => _StockholmMenuItemState();
}

class _StockholmMenuItemState extends State<StockholmMenuItem> {
  bool _hover = false;
  bool _selected = false;
  bool _flashing = false;

  Timer? _closeTimer;
  Timer? _toggleFlashTimer;

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.onSelected != null;
    var isWindows = Theme.of(context).platform == TargetPlatform.windows;
    var menuPadding = isWindows ? _menuPaddingWindows : _menuPadding;

    var menu = context.findAncestorWidgetOfExactType<StockholmMenu>();
    var menuWidth = menu?.width;
    if (menuWidth != null) menuWidth += menuPadding.horizontal * 2;

    TextStyle textStyle;
    if (enabled) {
      textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: (_hover || (_selected && _flashing)) && !isWindows
                ? Colors.white
                : null,
          );
    } else {
      textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).disabledColor,
          );
    }

    var highlightColor = isWindows
        ? Theme.of(context).highlightColor
        : Theme.of(context).primaryColor;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          if (!_selected && enabled) {
            _hover = true;
          }
        });
      },
      onExit: (_) {
        setState(() {
          _hover = false;
        });
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (enabled && !_selected) {
            _handleSelection(isWindows);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: isWindows ? 12 : 16),
          width: menuWidth,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius:
                isWindows ? null : const BorderRadius.all(Radius.circular(4.0)),
            color: _hover || (_selected && _flashing) ? highlightColor : null,
          ),
          child: DefaultTextStyle(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: widget.child),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSelection(bool isWindows) {
    _selected = true;

    // Close menu after a short delay.
    var closeDelay = isWindows ? 50 : 240;
    _closeTimer = Timer(Duration(milliseconds: closeDelay), () {
      Navigator.of(context).pop();
      if (widget.onSelected != null) {
        widget.onSelected!();
      }
    });

    // Start flashing the item.
    if (!isWindows) {
      _toggleFlash();
    }
  }

  void _toggleFlash() {
    setState(() {
      _hover = false;
      _flashing = !_flashing;
    });

    _toggleFlashTimer = Timer(const Duration(milliseconds: 80), _toggleFlash);
  }

  @override
  void dispose() {
    _closeTimer?.cancel();
    _toggleFlashTimer?.cancel();
    super.dispose();
  }
}

class StockholmMenuItemDivider extends StatelessWidget
    implements StockholmMenuEntity {
  const StockholmMenuItemDivider({Key? key}) : super(key: key);

  @override
  double get height => _menuDividerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _menuDividerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          color: Theme.of(context).dividerColor,
          height: 1.0,
        ),
      ),
    );
  }
}
