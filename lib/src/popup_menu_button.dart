import 'package:flutter/material.dart';

const double _kMenuHorizontalPadding = 16.0;
const double _kDefaultMenuItemHeight = 28.0;

/// Displays a menu when pressed and calls [onSelected] when the menu is dismissed
/// because an item was selected. The value passed to [onSelected] is the value of
/// the selected menu item.
///
/// One of [child] or [icon] may be provided, but not both. If [icon] is provided,
/// then [_StockholmPopupMenuButton] behaves like an [IconButton].
///
/// If both are null, then a standard overflow icon is created (depending on the
/// platform).
///
/// {@tool snippet}
///
/// This example shows a menu with four items, selecting between an enum's
/// values and setting a `_selection` field based on the selection.
///
/// ```dart
/// // This is the type used by the popup menu below.
/// enum WhyFarther { harder, smarter, selfStarter, tradingCharter }
///
/// // This menu button widget updates a _selection field (of type WhyFarther,
/// // not shown here).
/// PopupMenuButton<WhyFarther>(
///   onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
///   itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.harder,
///       child: Text('Working a lot harder'),
///     ),
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.smarter,
///       child: Text('Being a lot smarter'),
///     ),
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.selfStarter,
///       child: Text('Being a self-starter'),
///     ),
///     const PopupMenuItem<WhyFarther>(
///       value: WhyFarther.tradingCharter,
///       child: Text('Placed in charge of trading charter'),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [PopupMenuItem], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItem], a popup menu item with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
class StockholmPopupMenuButton<T> extends StatelessWidget {
  /// Creates a button that shows a popup menu.
  ///
  /// The [itemBuilder] argument must not be null.
  const StockholmPopupMenuButton({
    Key? key,
    required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 2,
    ),
    this.child,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    // this.shape,
    this.color,
    this.enableFeedback,
  })  : assert(
          !(child != null && icon != null),
          'You can only pass [child] or [icon], not both.',
        ),
        super(key: key);

  /// Called when the button is pressed to create the items to show in the menu.
  final PopupMenuItemBuilder<T> itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T? initialValue;

  /// Called when the user selects a value from the popup menu created by this button.
  ///
  /// If the popup menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final PopupMenuItemSelected<T>? onSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled? onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double? elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry padding;

  /// If provided, [child] is the widget used for this button
  /// and the button will utilize an [InkWell] for taps.
  final Widget? child;

  /// If provided, the [icon] is used for this button
  /// and the button will behave like an [IconButton].
  final Widget? icon;

  /// The offset applied to the Popup Menu Button.
  ///
  /// When not set, the Popup Menu Button will be positioned directly next to
  /// the button that was used to create it.
  final Offset offset;

  /// Whether this popup menu button is interactive.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the button will respond to presses by displaying the menu.
  ///
  /// If `false`, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [itemBuilder] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the shape used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.shape] is used.
  /// If [PopupMenuThemeData.shape] is also null, then the default shape for
  /// [MaterialType.card] is used. This default shape is a rectangle with
  /// rounded edges of BorderRadius.circular(2.0).
  // final ShapeBorder? shape;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.color] is used.
  /// If [PopupMenuThemeData.color] is also null, then
  /// Theme.of(context).cardColor is used.
  final Color? color;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// If provided, the size of the [Icon].
  ///
  /// If this property is null, the default size is 24.0 pixels.
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(hoverColor: theme.primaryColor),
      child: _StockholmPopupMenuButton(
        offset: offset,
        itemBuilder: itemBuilder,
        originalHoverColor: theme.hoverColor,
        child: child,
      ),
    );
  }
}

class _StockholmPopupMenuButton<T> extends StatefulWidget {
  /// Creates a button that shows a popup menu.
  ///
  /// The [itemBuilder] argument must not be null.
  const _StockholmPopupMenuButton({
    Key? key,
    required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 2,
    ),
    this.child,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    required this.originalHoverColor,
    // this.shape,
    this.color,
    this.enableFeedback,
  })  : assert(
          !(child != null && icon != null),
          'You can only pass [child] or [icon], not both.',
        ),
        super(key: key);

  final Color originalHoverColor;

  /// Called when the button is pressed to create the items to show in the menu.
  final PopupMenuItemBuilder<T> itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T? initialValue;

  /// Called when the user selects a value from the popup menu created by this button.
  ///
  /// If the popup menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final PopupMenuItemSelected<T>? onSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled? onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double? elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry padding;

  /// If provided, [child] is the widget used for this button
  /// and the button will utilize an [InkWell] for taps.
  final Widget? child;

  /// If provided, the [icon] is used for this button
  /// and the button will behave like an [IconButton].
  final Widget? icon;

  /// The offset applied to the Popup Menu Button.
  ///
  /// When not set, the Popup Menu Button will be positioned directly next to
  /// the button that was used to create it.
  final Offset offset;

  /// Whether this popup menu button is interactive.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the button will respond to presses by displaying the menu.
  ///
  /// If `false`, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [itemBuilder] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the shape used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.shape] is used.
  /// If [PopupMenuThemeData.shape] is also null, then the default shape for
  /// [MaterialType.card] is used. This default shape is a rectangle with
  /// rounded edges of BorderRadius.circular(2.0).
  // final ShapeBorder? shape;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.color] is used.
  /// If [PopupMenuThemeData.color] is also null, then
  /// Theme.of(context).cardColor is used.
  final Color? color;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// If provided, the size of the [Icon].
  ///
  /// If this property is null, the default size is 24.0 pixels.
  final double? iconSize;

  @override
  _StockholmPopupMenuButtonState<T> createState() =>
      _StockholmPopupMenuButtonState<T>();
}

/// The [State] for a [_StockholmPopupMenuButton].
///
/// See [showButtonMenu] for a way to programmatically open the popup menu
/// of your button state.
class _StockholmPopupMenuButtonState<T>
    extends State<_StockholmPopupMenuButton<T>> {
  /// A method to show a popup menu with the items supplied to
  /// [_StockholmPopupMenuButton.itemBuilder] at the position of your [_StockholmPopupMenuButton].
  ///
  /// By default, it is called when the user taps the button and [_StockholmPopupMenuButton.enabled]
  /// is set to `true`. Moreover, you can open the button by calling the method manually.
  ///
  /// You would access your [_StockholmPopupMenuButtonState] using a [GlobalKey] and
  /// show the menu of the button with `globalKey.currentState.showButtonMenu`.
  void showButtonMenu() {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(
            button.size.bottomRight(Offset.zero) + widget.offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final List<PopupMenuEntry<T>> items = widget.itemBuilder(context);
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T?>(
        context: context,
        elevation: widget.elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        color: widget.color ?? popupMenuTheme.color,
      ).then<void>((T? newValue) {
        if (!mounted) return null;
        if (newValue == null) {
          widget.onCanceled?.call();
          return null;
        }
        widget.onSelected?.call(newValue);
      });
    }
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.enabled;
      case NavigationMode.directional:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool enableFeedback = widget.enableFeedback ??
        PopupMenuTheme.of(context).enableFeedback ??
        true;

    assert(debugCheckHasMaterialLocalizations(context));

    Widget button;
    if (widget.child != null) {
      button = InkWell(
        onTap: widget.enabled ? showButtonMenu : null,
        canRequestFocus: _canRequestFocus,
        enableFeedback: enableFeedback,
        child: widget.child,
      );
    } else {
      button = IconButton(
        icon: widget.icon ?? Icon(Icons.adaptive.more),
        padding: widget.padding,
        iconSize: widget.iconSize ?? 24.0,
        tooltip: widget.tooltip,
        onPressed: widget.enabled ? showButtonMenu : null,
        enableFeedback: enableFeedback,
        // hoverColor: Theme.of(context).hoverColor,
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(hoverColor: widget.originalHoverColor),
      child: button,
    );

    // return Theme(
    //   // data: ThemeData(
    //   //   hoverColor: ,
    //   // ),
    //   child: Builder(builder: (context) { return button; }),
    // );
  }
}

/// An item in a material design popup menu.
///
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [_StockholmPopupMenuButton].
///
/// To show a checkmark next to a popup menu item, consider using
/// [CheckedPopupMenuItem].
///
/// Typically the [child] of a [PopupMenuItem] is a [Text] widget. More
/// elaborate menus with icons can use a [ListTile]. By default, a
/// [PopupMenuItem] is [kMinInteractiveDimension] pixels high. If you use a widget
/// with a different height, it must be specified in the [height] property.
///
/// {@tool snippet}
///
/// Here, a [Text] widget is used with a popup menu item. The `WhyFarther` type
/// is an enum, not shown here.
///
/// ```dart
/// const PopupMenuItem<WhyFarther>(
///   value: WhyFarther.harder,
///   child: Text('Working a lot harder'),
/// )
/// ```
/// {@end-tool}
///
/// See the example at [_StockholmPopupMenuButton] for how this example could be used in a
/// complete menu, and see the example at [CheckedPopupMenuItem] for one way to
/// keep the text of [PopupMenuItem]s that use [Text] widgets in their [child]
/// slot aligned with the text of [CheckedPopupMenuItem]s or of [PopupMenuItem]
/// that use a [ListTile] in their [child] slot.
///
/// See also:
///
///  * [PopupMenuDivider], which can be used to divide items from each other.
///  * [CheckedPopupMenuItem], a variant of [PopupMenuItem] with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [_StockholmPopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class StockholmPopupMenuItem<T> extends PopupMenuEntry<T> {
  /// Creates an item for a popup menu.
  ///
  /// By default, the item is [enabled].
  ///
  /// The `enabled` and `height` arguments must not be null.
  const StockholmPopupMenuItem({
    Key? key,
    this.value,
    this.onTap,
    this.enabled = true,
    this.height = _kDefaultMenuItemHeight,
    this.padding,
    this.textStyle,
    this.mouseCursor,
    required this.child,
  }) : super(key: key);

  /// The value that will be returned by [showMenu] if this entry is selected.
  final T? value;

  /// Called when the menu item is tapped.
  final VoidCallback? onTap;

  /// Whether the user is permitted to select this item.
  ///
  /// Defaults to true. If this is false, then the item will not react to
  /// touches.
  final bool enabled;

  /// The minimum height of the menu item.
  ///
  /// Defaults to [kMinInteractiveDimension] pixels.
  @override
  final double height;

  /// The padding of the menu item.
  ///
  /// Note that [height] may interact with the applied padding. For example,
  /// If a [height] greater than the height of the sum of the padding and [child]
  /// is provided, then the padding's effect will not be visible.
  ///
  /// When null, the horizontal padding defaults to 16.0 on both sides.
  final EdgeInsets? padding;

  /// The text style of the popup menu item.
  ///
  /// If this property is null, then [PopupMenuThemeData.textStyle] is used.
  /// If [PopupMenuThemeData.textStyle] is also null, then [TextTheme.subtitle1]
  /// of [ThemeData.textTheme] is used.
  final TextStyle? textStyle;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]:
  ///
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The widget below this widget in the tree.
  ///
  /// Typically a single-line [ListTile] (for menus with icons) or a [Text]. An
  /// appropriate [DefaultTextStyle] is put in scope for the child. In either
  /// case, the text should be short enough that it won't wrap.
  final Widget? child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  StockholmPopupMenuItemState<T, StockholmPopupMenuItem<T>> createState() =>
      StockholmPopupMenuItemState<T, StockholmPopupMenuItem<T>>();
}

/// The [State] for [PopupMenuItem] subclasses.
///
/// By default this implements the basic styling and layout of Material Design
/// popup menu items.
///
/// The [buildChild] method can be overridden to adjust exactly what gets placed
/// in the menu. By default it returns [PopupMenuItem.child].
///
/// The [handleTap] method can be overridden to adjust exactly what happens when
/// the item is tapped. By default, it uses [Navigator.pop] to return the
/// [PopupMenuItem.value] from the menu route.
///
/// This class takes two type arguments. The second, `W`, is the exact type of
/// the [Widget] that is using this [State]. It must be a subclass of
/// [PopupMenuItem]. The first, `T`, must match the type argument of that widget
/// class, and is the type of values returned from this menu.
class StockholmPopupMenuItemState<T, W extends StockholmPopupMenuItem<T>>
    extends State<W> {
  /// The menu item contents.
  ///
  /// Used by the [build] method.
  ///
  /// By default, this returns [PopupMenuItem.child]. Override this to put
  /// something else in the menu entry.
  @protected
  Widget? buildChild() => widget.child;

  /// The handler for when the user selects the menu item.
  ///
  /// Used by the [InkWell] inserted by the [build] method.
  ///
  /// By default, uses [Navigator.pop] to return the [PopupMenuItem.value] from
  /// the menu route.
  @protected
  void handleTap() {
    widget.onTap?.call();

    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle style = widget.textStyle ??
        popupMenuTheme.textStyle ??
        theme.textTheme.subtitle1!;

    if (!widget.enabled) style = style.copyWith(color: theme.disabledColor);

    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: widget.height),
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
        child: buildChild(),
      ),
    );

    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }
    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!widget.enabled) MaterialState.disabled,
      },
    );

    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: InkWell(
          onTap: widget.enabled ? handleTap : null,
          canRequestFocus: widget.enabled,
          mouseCursor: effectiveMouseCursor,
          child: item,
        ),
      ),
    );
  }
}
