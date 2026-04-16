import 'package:flutter/cupertino.dart';

/// Shared border / fill used by [StockholmDateTimePicker].
const Color kStockholmDateTimeDisabledBackground =
    CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFAFAFA),
  darkColor: Color(0xFF050505),
);

const BorderSide kStockholmDateTimeFieldBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  width: 0.0,
);

const Border kStockholmDateTimeFieldBorder = Border(
  top: kStockholmDateTimeFieldBorderSide,
  bottom: kStockholmDateTimeFieldBorderSide,
  left: kStockholmDateTimeFieldBorderSide,
  right: kStockholmDateTimeFieldBorderSide,
);

const BoxDecoration kStockholmDateTimeFieldDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: kStockholmDateTimeFieldBorder,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

/// Resolves dynamic border colors and background for date/time segments.
BoxDecoration stockholmDateTimeSegmentDecoration(
  BuildContext context, {
  required bool enabled,
}) {
  final Color disabledColor = CupertinoDynamicColor.resolve(
      kStockholmDateTimeDisabledBackground, context);

  final Color? decorationColor = CupertinoDynamicColor.maybeResolve(
      kStockholmDateTimeFieldDecoration.color, context);

  final BoxBorder? border = kStockholmDateTimeFieldDecoration.border;
  Border? resolvedBorder = border as Border?;
  if (border is Border) {
    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(
              color: CupertinoDynamicColor.resolve(side.color, context),
            );
    }

    resolvedBorder = border.runtimeType != Border
        ? border
        : Border(
            top: resolveBorderSide(border.top),
            left: resolveBorderSide(border.left),
            bottom: resolveBorderSide(border.bottom),
            right: resolveBorderSide(border.right),
          );
  }

  return kStockholmDateTimeFieldDecoration.copyWith(
    border: resolvedBorder,
    color: enabled ? decorationColor : disabledColor,
  );
}
