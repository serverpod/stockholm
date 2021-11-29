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
      // popupMenuTheme: PopupMenuThemeData(
      //   textStyle: TextStyle(
      //     fontSize: 20.0,
      //   ),
      // ),
      // textTheme: TextTheme(
      //   bodyText1: TextStyle(fontSize: 12.0),
      //   bodyText2: TextStyle(fontSize: 12.0),
      //   caption: TextStyle(fontSize: 11.0),
      //   button: TextStyle(fontSize: 14.0),
      // ),
    );

    // return ThemeData.light().copyWith(
    //   // primarySwatch: Colors.blue,
    //   visualDensity: VisualDensity.compact,
    //   backgroundColor: Colors.blueGrey[50],
    //   // popupMenuTheme: PopupMenuThemeData(
    //   //   textStyle: TextStyle(
    //   //     fontSize: 20.0,
    //   //   ),
    //   // ),
    //   textTheme: TextTheme(
    //     bodyText1: TextStyle(fontSize: 12.0),
    //     bodyText2: TextStyle(fontSize: 12.0),
    //     caption: TextStyle(fontSize: 11.0),
    //     button: TextStyle(fontSize: 14.0),
    //   ),
    // );
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
      popupMenuTheme: theme.popupMenuTheme.copyWith(
        textStyle: theme.textTheme.bodyText1,
      ),
      splashColor: Colors.transparent,
    );
  }
}