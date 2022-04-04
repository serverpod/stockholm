import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stockholm/src/button.dart';
import 'package:stockholm/src/menu_items.dart';

const _minMenuEdgePadding = 8.0;

class TestButton extends StatefulWidget {
  const TestButton({Key? key}) : super(key: key);

  @override
  _TestButtonState createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
  @override
  Widget build(BuildContext context) {
    return StockholmButton(
      onPressed: () {
        showTestMenu();
      },
      child: const Text('Test'),
    );
  }

  void showTestMenu() {
    var bounds = getGlobalBoundsForContext(context);
    var anchorPoint = Offset(bounds.left, bounds.top);

    var menu = StockholmMenu(
      items: [
        StockholmMenuItem(
          child: const Text('Item 1'),
          onSelected: () {
            print('Selected item 1');
          },
        ),
        const StockholmMenuItem(
          child: Text('Item 2 which is longer and disabled super duper long'),
        ),
        const StockholmMenuItemDivider(),
        StockholmMenuItem(
          child: const Text('Item 3'),
          onSelected: () {
            print('Selected item 3');
          },
        ),
      ],
    );

    showStockholmMenu(
      context: context,
      // alignment: Alignment.bottomRight,
      preferredAnchorPoint: anchorPoint,
      menu: menu,
    );
  }
}

Rect getGlobalBoundsForContext(BuildContext context) {
  var renderBox = context.findRenderObject() as RenderBox;
  var overlay =
      Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

  return Rect.fromPoints(
    renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    ),
    renderBox.localToGlobal(
      renderBox.size.bottomRight(Offset.zero),
      ancestor: overlay,
    ),
  );
}

Future showStockholmMenu({
  required BuildContext context,
  required Offset preferredAnchorPoint,
  required StockholmMenu menu,
  Alignment alignment = Alignment.topLeft,
  String? semanticLabel,
  bool useRootNavigator = false,
}) {
  assert(debugCheckHasMaterialLocalizations(context));

  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      semanticLabel ??= MaterialLocalizations.of(context).popupMenuLabel;
  }

  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push(_PopupMenuRoute(
    preferredAnchorPoint: preferredAnchorPoint,
    alignment: alignment,
    semanticLabel: semanticLabel,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    capturedThemes:
        InheritedTheme.capture(from: context, to: navigator.context),
    menu: menu,
  ));
}

class _PopupMenuRoute extends PopupRoute {
  _PopupMenuRoute({
    required this.preferredAnchorPoint,
    required this.alignment,
    required this.barrierLabel,
    this.semanticLabel,
    required this.capturedThemes,
    required this.menu,
  });

  final Offset preferredAnchorPoint;
  final String? semanticLabel;
  final CapturedThemes capturedThemes;
  final StockholmMenu menu;
  final Alignment alignment;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _PopupMenuRouteLayout(
              preferredAnchorPoint,
              alignment,
              Directionality.of(context),
              mediaQuery.padding,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(
    this.preferredAnchorPoint,
    this.alignment,
    this.textDirection,
    this.padding,
  );

  // Rectangle of underlying button, relative to the overlay's dimensions.
  // final RelativeRect position;
  final Offset preferredAnchorPoint;

  final Alignment alignment;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  // The padding of unsafe area.
  EdgeInsets padding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest).deflate(
      const EdgeInsets.all(8.0) + padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    print('childSize: $childSize');
    print('size: $size');

    // Take alignment into account.
    var x = preferredAnchorPoint.dx - (alignment.x + 1) / 2 * childSize.width;
    var y = preferredAnchorPoint.dy - (alignment.y + 1) / 2 * childSize.height;

    // Push the menu inside the bounds if necessary.
    if (x < _minMenuEdgePadding) {
      x = _minMenuEdgePadding;
    }
    if (y < _minMenuEdgePadding) {
      y = _minMenuEdgePadding;
    }
    if (x > size.width - _minMenuEdgePadding - childSize.width) {
      x = size.width - _minMenuEdgePadding - childSize.width;
    }
    if (y > size.height - _minMenuEdgePadding - childSize.height) {
      y = size.height - _minMenuEdgePadding - childSize.height;
    }
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // final double buttonHeight = size.height - position.top - position.bottom;
    // // Find the ideal vertical position.
    // double y = position.top;
    // if (selectedItemIndex != null && itemSizes != null) {
    //   double selectedItemOffset = _kMenuVerticalPadding;
    //   for (int index = 0; index < selectedItemIndex!; index += 1)
    //     selectedItemOffset += itemSizes[index]!.height;
    //   selectedItemOffset += itemSizes[selectedItemIndex!]!.height / 2;
    //   y = y + buttonHeight / 2.0 - selectedItemOffset;
    // }
    //
    // // Find the ideal horizontal position.
    // double x;
    // if (position.left > position.right) {
    //   // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
    //   x = size.width - position.right - childSize.width;
    // } else if (position.left < position.right) {
    //   // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
    //   x = position.left;
    // } else {
    //   // Menu button is equidistant from both edges, so grow in reading direction.
    //   assert(textDirection != null);
    //   switch (textDirection) {
    //     case TextDirection.rtl:
    //       x = size.width - position.right - childSize.width;
    //       break;
    //     case TextDirection.ltr:
    //       x = position.left;
    //       break;
    //   }
    // }
    //
    // // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // // edge of the screen in every direction.
    // if (x < _kMenuScreenPadding + padding.left)
    //   x = _kMenuScreenPadding + padding.left;
    // else if (x + childSize.width > size.width - _kMenuScreenPadding - padding.right)
    //   x = size.width - childSize.width - _kMenuScreenPadding - padding.right  ;
    // if (y < _kMenuScreenPadding + padding.top)
    //   y = _kMenuScreenPadding + padding.top;
    // else if (y + childSize.height > size.height - _kMenuScreenPadding - padding.bottom)
    //   y = size.height - padding.bottom - _kMenuScreenPadding - childSize.height ;
    //
    // return Offset(x, y);
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    // If called when the old and new itemSizes have been initialized then
    // we expect them to have the same length because there's no practical
    // way to change length of the items list once the menu has been shown.
    // assert(itemSizes.length == oldDelegate.itemSizes.length);

    return preferredAnchorPoint != oldDelegate.preferredAnchorPoint ||
        textDirection != oldDelegate.textDirection ||
        padding != oldDelegate.padding;
  }
}
