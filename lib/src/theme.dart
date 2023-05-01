import 'package:flutter/material.dart';
import 'package:stockholm/src/colors.dart';

class StockholmThemeData {
  static ThemeData light({
    StockholmColor? accentColor,
    TargetPlatform? platform,
  }) {
    var theme = ThemeData.light();
    var colors = StockholmColors.fromBrightness(Brightness.light);
    accentColor ??= colors.blue;
    platform ??= theme.platform;
    var isWindows = platform == TargetPlatform.windows;

    theme = _applySharedChanges(theme, platform);

    var highlightColor = platform == TargetPlatform.windows
        ? Colors.black.withOpacity(0.05)
        : Colors.black26;

    return theme.copyWith(
      visualDensity: VisualDensity.compact,
      primaryColor: accentColor,
      indicatorColor: accentColor,
      highlightColor: highlightColor,
      disabledColor: Colors.black26,
      colorScheme: theme.colorScheme.copyWith(
        primary: accentColor,
        secondary: accentColor.contrast,
        background: Colors.blueGrey[50],
        surface: Colors.grey[100],
      ),
      popupMenuTheme: theme.popupMenuTheme.copyWith(
        textStyle: theme.textTheme.bodyMedium,
        color: Colors.grey.shade100,
      ),
      dialogTheme: theme.dialogTheme.copyWith(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(isWindows ? 8 : 12)),
            side: const BorderSide(color: Colors.black12, width: 1.0),
          )),
      textTheme: theme.textTheme.copyWith(
        bodySmall: theme.textTheme.bodySmall!.copyWith(color: Colors.black38),
      ),
      iconTheme: theme.iconTheme.copyWith(
        color: Colors.grey[700],
      ),
      platform: platform,
    );
  }

  static ThemeData dark({
    StockholmColor? accentColor,
    TargetPlatform? platform,
  }) {
    var theme = ThemeData.dark();
    var colors = StockholmColors.fromBrightness(Brightness.dark);
    accentColor ??= colors.blue;
    platform ??= theme.platform;
    var isWindows = platform == TargetPlatform.windows;

    theme = _applySharedChanges(theme, platform);

    var highlightColor = platform == TargetPlatform.windows
        ? Colors.white.withOpacity(0.075)
        : Colors.white10;

    return theme.copyWith(
      primaryColor: accentColor,
      popupMenuTheme: theme.popupMenuTheme.copyWith(
        textStyle: theme.textTheme.bodyMedium,
        color: Colors.grey.shade900,
      ),
      colorScheme: theme.colorScheme.copyWith(
        primary: accentColor,
        secondary: accentColor.contrast,
        background: const Color.fromRGBO(44, 44, 44, 1.0),
        surface: Colors.grey[800],
      ),
      indicatorColor: accentColor,
      highlightColor: highlightColor,
      scaffoldBackgroundColor: Colors.grey[900],
      canvasColor: const Color.fromRGBO(38, 38, 38, 1.0),
      hoverColor: Colors.white12,
      cardColor: Colors.grey[900],
      dividerColor: Colors.white24,
      dialogTheme: theme.dialogTheme.copyWith(
        backgroundColor: const Color.fromRGBO(44, 44, 44, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(isWindows ? 8 : 12),
          ),
          side: BorderSide(color: Colors.grey[700]!, width: 1.0),
        ),
      ),
      platform: platform,
    );
  }

  static ThemeData _applySharedChanges(
    ThemeData theme,
    TargetPlatform platform,
  ) {
    if (platform == TargetPlatform.windows) {
      return theme.copyWith(
        visualDensity: VisualDensity.compact,
        textTheme: theme.textTheme.copyWith(
          bodyLarge: theme.textTheme.bodyLarge!.copyWith(fontSize: 13.0),
          bodyMedium: theme.textTheme.bodyMedium!.copyWith(fontSize: 12.0),
          titleLarge: theme.textTheme.bodyLarge!
              .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
          titleMedium: theme.textTheme.bodyLarge!
              .copyWith(fontSize: 13.0, fontWeight: FontWeight.bold),
          titleSmall: theme.textTheme.bodyMedium!
              .copyWith(fontSize: 12.0, fontWeight: FontWeight.bold),
          bodySmall: theme.textTheme.bodySmall!
              .copyWith(fontSize: 10.5, fontWeight: FontWeight.bold),
          labelLarge: theme.textTheme.labelLarge!.copyWith(fontSize: 14.0),
        ),
        splashColor: Colors.transparent,
        expansionTileTheme: ExpansionTileThemeData(
          textColor: theme.colorScheme.onSurface,
          iconColor: theme.colorScheme.onSurface,
          shape: const Border(),
          collapsedShape: const Border(),
        ),
      );
    } else {
      return theme.copyWith(
        visualDensity: VisualDensity.compact,
        textTheme: theme.textTheme.copyWith(
          bodyLarge: theme.textTheme.bodyLarge!.copyWith(fontSize: 13.0),
          bodyMedium: theme.textTheme.bodyMedium!.copyWith(fontSize: 12.0),
          titleMedium: theme.textTheme.bodyLarge!
              .copyWith(fontSize: 13.0, fontWeight: FontWeight.bold),
          titleSmall: theme.textTheme.bodyMedium!
              .copyWith(fontSize: 12.0, fontWeight: FontWeight.bold),
          bodySmall: theme.textTheme.bodySmall!
              .copyWith(fontSize: 10.5, fontWeight: FontWeight.bold),
          labelLarge: theme.textTheme.labelLarge!.copyWith(fontSize: 14.0),
        ),
        splashColor: Colors.transparent,
        expansionTileTheme: ExpansionTileThemeData(
          textColor: theme.colorScheme.onSurface,
          iconColor: theme.colorScheme.onSurface,
          shape: const Border(),
          collapsedShape: const Border(),
        ),
      );
    }
  }
}
