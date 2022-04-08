import 'package:flutter/material.dart';

abstract class StockholmColors {
  StockholmColors();

  factory StockholmColors.fromBrightness(Brightness brightness) {
    if (brightness == Brightness.light) {
      return StockholmLightColors();
    } else {
      return StockholmDarkColors();
    }
  }

  factory StockholmColors.fromContext(BuildContext context) {
    return StockholmColors.fromBrightness(Theme.of(context).brightness);
  }

  Color get blue;
  Color get purple;
  Color get pink;
  Color get red;
  Color get orange;
  Color get yellow;
  Color get green;
  Color get gray;

  Color get blueContrast;
  Color get purpleContrast;
  Color get pinkContrast;
  Color get redContrast;
  Color get orangeContrast;
  Color get yellowContrast;
  Color get greenContrast;
  Color get grayContrast;
}

class StockholmLightColors extends StockholmColors {
  @override
  final blue = const Color.fromRGBO(53, 120, 246, 1.0);
  @override
  final purple = const Color.fromRGBO(138, 67, 146, 1.0);
  @override
  final pink = const Color.fromRGBO(228, 92, 156, 1.0);
  @override
  final red = const Color.fromRGBO(206, 71, 69, 1.0);
  @override
  final orange = const Color.fromRGBO(231, 136, 57, 1.0);
  @override
  final yellow = const Color.fromRGBO(246, 201, 77, 1.0);
  @override
  final green = const Color.fromRGBO(120, 184, 86, 1.0);
  @override
  final gray = const Color.fromRGBO(152, 152, 152, 1.0);
  @override
  get blueContrast => blue.darken();
  @override
  get purpleContrast => purple.darken();
  @override
  get pinkContrast => pink.darken();
  @override
  get redContrast => red.darken();
  @override
  get orangeContrast => orange.darken();
  @override
  get yellowContrast => yellow.darken(0.2);
  @override
  get greenContrast => green.darken();
  @override
  get grayContrast => gray.darken();
}

class StockholmDarkColors extends StockholmColors {
  @override
  final blue = const Color.fromRGBO(53, 120, 246, 1.0);
  @override
  final purple = const Color.fromRGBO(154, 84, 163, 1.0);
  @override
  final pink = const Color.fromRGBO(228, 92, 156, 1.0);
  @override
  final red = const Color.fromRGBO(236, 95, 93, 1.0);
  @override
  final orange = const Color.fromRGBO(232, 136, 57, 1.0);
  @override
  final yellow = const Color.fromRGBO(246, 200, 67, 1.0);
  @override
  final green = const Color.fromRGBO(120, 184, 86, 1.0);
  @override
  final gray = const Color.fromRGBO(140, 140, 140, 1.0);
  @override
  get blueContrast => blue.lighten();
  @override
  get purpleContrast => purple.lighten();
  @override
  get pinkContrast => pink.lighten();
  @override
  get redContrast => red.lighten();
  @override
  get orangeContrast => orange.lighten();
  @override
  get yellowContrast => yellow.lighten();
  @override
  get greenContrast => green.lighten();
  @override
  get grayContrast => gray.lighten();
}

extension ColorExt on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
