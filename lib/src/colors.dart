import 'package:flutter/material.dart';

abstract class StockholmColors {
  StockholmColors();

  factory StockholmColors.fromBrightness(
    Brightness brightness, [
    TargetPlatform platform = TargetPlatform.macOS,
  ]) {
    if (platform == TargetPlatform.windows) {
      if (brightness == Brightness.light) {
        return StockholmLightWindowsColors();
      } else {
        return StockholmDarkWindowsColors();
      }
    } else {
      if (brightness == Brightness.light) {
        return StockholmLightColors();
      } else {
        return StockholmDarkColors();
      }
    }
  }

  factory StockholmColors.fromContext(BuildContext context) {
    var theme = Theme.of(context);
    return StockholmColors.fromBrightness(
      theme.brightness,
      theme.platform,
    );
  }

  StockholmColor get blue;
  StockholmColor get purple;
  StockholmColor get pink;
  StockholmColor get red;
  StockholmColor get orange;
  StockholmColor get yellow;
  StockholmColor get green;
  StockholmColor get gray;
}

class StockholmLightColors extends StockholmColors {
  @override
  final blue = const StockholmColor(
    0xff3578f6,
    Color(0xff6699f8),
    Color(0xff0b59ed),
    Brightness.light,
  );

  @override
  final purple = const StockholmColor(
    0xff8a4392,
    Color(0xffa856b2),
    Color(0xff69336f),
    Brightness.light,
  );

  @override
  final pink = const StockholmColor(
    0xffe45c9c,
    Color(0xffeb88b7),
    Color(0xffdd3081),
    Brightness.light,
  );

  @override
  final red = const StockholmColor(
    0xffce4745,
    Color(0xffd96f6d),
    Color(0xffb1312f),
    Brightness.light,
  );

  @override
  final orange = const StockholmColor(
    0xffe78839,
    Color(0xffeda366),
    Color(0xffd36e1a),
    Brightness.light,
  );

  @override
  final yellow = const StockholmColor(
    0xfff6c94d,
    Color(0xfffbe6ae),
    Color(0xffd29d0b),
    Brightness.light,
  );

  @override
  final green = const StockholmColor(
    0xff78b856,
    Color(0xff95c77a),
    Color(0xff609a41),
    Brightness.light,
  );

  @override
  final gray = const StockholmColor(
    0xff989898,
    Color(0xffb2b2b2),
    Color(0xff7f7f7f),
    Brightness.light,
  );
}

class StockholmDarkColors extends StockholmColors {
  @override
  final blue = const StockholmColor(
    0xff3578f6,
    Color(0xff6699f8),
    Color(0xff0b59ed),
    Brightness.dark,
  );

  @override
  final purple = const StockholmColor(
    0xff9a54a3,
    Color(0xffaf73b7),
    Color(0xff7a4381),
    Brightness.dark,
  );

  @override
  final pink = const StockholmColor(
    0xffe45c9c,
    Color(0xffeb88b7),
    Color(0xffdd3081),
    Brightness.dark,
  );

  @override
  final red = const StockholmColor(
    0xffec5f5d,
    Color(0xfff18c8b),
    Color(0xffe7322f),
    Brightness.dark,
  );

  @override
  final orange = const StockholmColor(
    0xffe88839,
    Color(0xffeda367),
    Color(0xffd56e19),
    Brightness.dark,
  );

  @override
  final yellow = const StockholmColor(
    0xfff6c843,
    Color(0xfff8d674),
    Color(0xffc9980a),
    Brightness.dark,
  );

  @override
  final green = const StockholmColor(
    0xff78b856,
    Color(0xff95c77a),
    Color(0xff609a41),
    Brightness.dark,
  );

  @override
  final gray = const StockholmColor(
    0xff989898,
    Color(0xffb2b2b2),
    Color(0xff7f7f7f),
    Brightness.dark,
  );
}

class StockholmLightWindowsColors extends StockholmColors {
  @override
  final blue = const StockholmColor(
    0xff0078d4,
    Color(0xff60abe4),
    Color(0xff004a83),
    Brightness.light,
  );

  @override
  final purple = const StockholmColor(
    0xFF744da9,
    Color(0xffa890c9),
    Color(0xff472f68),
    Brightness.light,
  );

  @override
  final pink = const StockholmColor(
    0xffb4009e,
    Color(0xffd060c2),
    Color(0xff6f0061),
    Brightness.light,
  );

  @override
  final red = const StockholmColor(
    0xffe81123,
    Color(0xfff06b76),
    Color(0xff8f0a15),
    Brightness.light,
  );

  @override
  final orange = const StockholmColor(
    0xfff7630c,
    Color(0xfffa9e68),
    Color(0xff993d07),
    Brightness.light,
  );

  @override
  final yellow = const StockholmColor(
    0xffffeb3b,
    Color(0xfffff59d),
    Color(0xfff9a825),
    Brightness.light,
  );

  @override
  final green = const StockholmColor(
    0xff107c10,
    Color(0xff6aad6a),
    Color(0xff094c09),
    Brightness.light,
  );

  @override
  final gray = const StockholmColor(
    0xff989898,
    Color(0xffb2b2b2),
    Color(0xff7f7f7f),
    Brightness.light,
  );
}

class StockholmDarkWindowsColors extends StockholmColors {
  @override
  final blue = const StockholmColor(
    0xff0078d4,
    Color(0xff60abe4),
    Color(0xff004a83),
    Brightness.dark,
  );

  @override
  final purple = const StockholmColor(
    0xFF744da9,
    Color(0xffa890c9),
    Color(0xff472f68),
    Brightness.dark,
  );

  @override
  final pink = const StockholmColor(
    0xffb4009e,
    Color(0xffd060c2),
    Color(0xff6f0061),
    Brightness.dark,
  );

  @override
  final red = const StockholmColor(
    0xffe81123,
    Color(0xfff06b76),
    Color(0xff8f0a15),
    Brightness.dark,
  );

  @override
  final orange = const StockholmColor(
    0xfff7630c,
    Color(0xfffa9e68),
    Color(0xff993d07),
    Brightness.dark,
  );

  @override
  final yellow = const StockholmColor(
    0xffffeb3b,
    Color(0xfffff59d),
    Color(0xfff9a825),
    Brightness.dark,
  );

  @override
  final green = const StockholmColor(
    0xff107c10,
    Color(0xff6aad6a),
    Color(0xff094c09),
    Brightness.dark,
  );

  @override
  final gray = const StockholmColor(
    0xff989898,
    Color(0xffb2b2b2),
    Color(0xff7f7f7f),
    Brightness.dark,
  );
}

class StockholmColor extends Color {
  const StockholmColor(
    int value,
    this.light,
    this.dark,
    this.brightness,
  ) : super(value);

  final Brightness brightness;

  final Color light;
  final Color dark;

  Color get contrast => brightness == Brightness.light ? dark : light;
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
