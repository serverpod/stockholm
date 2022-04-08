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
}
