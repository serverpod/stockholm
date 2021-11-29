import 'package:flutter/material.dart';

class StockholmThemeData {
  static ThemeData light() {
    var theme = ThemeData.light();

    theme = _applySharedChanges(theme);

    return theme.copyWith(
      primaryColorBrightness: Brightness.light,
      // primarySwatch: Colors.blue,
      visualDensity: VisualDensity.compact,
      backgroundColor: Colors.blueGrey[50],
      primaryColor: Colors.blue[500],
      popupMenuTheme: theme.popupMenuTheme.copyWith(
        textStyle: theme.textTheme.bodyText1,
      ),
    );
  }

  static ThemeData dark() {
    var theme = ThemeData.dark();

    theme = _applySharedChanges(theme);

    return theme.copyWith(
      primaryColor: Colors.blue[700],
      popupMenuTheme: theme.popupMenuTheme.copyWith(
        textStyle: theme.textTheme.bodyText1,
      ),
      splashColor: Colors.transparent,
      canvasColor: Colors.black,
      hoverColor: Colors.white12,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          textStyle: theme.textTheme.bodyText1!.copyWith(fontSize: 12.0),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            side: BorderSide(color: theme.dividerColor, width: 1),
          ),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardColor: Colors.grey[900],
      dividerColor: Colors.white24,
    );
  }

  static ThemeData _applySharedChanges(ThemeData theme) {
    return theme.copyWith(
      visualDensity: VisualDensity.compact,
      textTheme: theme.textTheme.copyWith(
        bodyText1: theme.textTheme.bodyText1!.copyWith(fontSize: 12.0),
        bodyText2: theme.textTheme.bodyText2!.copyWith(fontSize: 12.0),
        caption: theme.textTheme.caption!.copyWith(fontSize: 11.0),
        button: theme.textTheme.button!.copyWith(fontSize: 14.0),
      ),
      splashColor: Colors.transparent,
    );
  }
}