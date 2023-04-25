import 'dart:io';

import 'package:example/src/buttons.dart';
import 'package:example/src/colors.dart';
import 'package:example/src/dialogs.dart';
import 'package:example/src/inspector.dart';
import 'package:example/src/menus.dart';
import 'package:example/src/tables.dart';
import 'package:example/src/text_fields.dart';
import 'package:example/src/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stockholm/stockholm.dart';

enum _DemoPage {
  buttons,
  menus,
  tables,
  dialogs,
  toolbar,
  colors,
  textFields,
  propertyInspector,
}

enum _ThemeColor {
  blue,
  purple,
  pink,
  red,
  orange,
  yellow,
  green,
  gray,
}

enum _PlatformAppearance {
  macOS,
  windows,
}

void main() {
  runApp(const StockholmDemoApp());
}

class StockholmDemoApp extends StatefulWidget {
  const StockholmDemoApp({Key? key}) : super(key: key);

  @override
  _StockholmDemoAppState createState() => _StockholmDemoAppState();

  static _StockholmDemoAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_StockholmDemoAppState>()!;
  }
}

class _StockholmDemoAppState extends State<StockholmDemoApp> {
  bool _darkMode = false;
  _ThemeColor _themeColor = _ThemeColor.blue;
  _PlatformAppearance _platform = _PlatformAppearance.macOS;

  bool get darkMode => _darkMode;

  set darkMode(bool darkMode) {
    setState(() {
      _darkMode = darkMode;
    });
  }

  _ThemeColor get themeColor => _themeColor;

  set themeColor(_ThemeColor themeColor) {
    setState(() {
      _themeColor = themeColor;
    });
  }

  _PlatformAppearance get platform => _platform;

  set platform(_PlatformAppearance platform) {
    setState(() {
      _platform = platform;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      _platform = _PlatformAppearance.windows;
    } else {
      _platform = _PlatformAppearance.macOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    var platform = _platform == _PlatformAppearance.macOS
        ? TargetPlatform.macOS
        : TargetPlatform.windows;

    var theme = _darkMode
        ? StockholmThemeData.dark(
            accentColor: _themeColorToStockholmColor(
              _themeColor,
              Brightness.dark,
              platform,
            ),
            platform: platform,
          )
        : StockholmThemeData.light(
            accentColor: _themeColorToStockholmColor(
              _themeColor,
              Brightness.light,
              platform,
            ),
            platform: platform,
          );

    return MaterialApp(
      title: 'Stockholm Demo',
      theme: theme,
      home: const StockholmHomePage(),
    );
  }
}

class StockholmHomePage extends StatefulWidget {
  const StockholmHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StockholmHomePage> createState() => _StockholmHomePageState();
}

class _StockholmHomePageState extends State<StockholmHomePage> {
  _DemoPage _selectedPage = _DemoPage.buttons;

  @override
  Widget build(BuildContext context) {
    Widget page;

    var appState = StockholmDemoApp.of(context);

    switch (_selectedPage) {
      case _DemoPage.buttons:
        page = const StockholmButtonDemoPage();
        break;
      case _DemoPage.tables:
        page = const StockholmTableDemoPage();
        break;
      case _DemoPage.menus:
        page = const StockholmMenuDemoPage();
        break;
      case _DemoPage.dialogs:
        page = const StockholmDialogDemoPage();
        break;
      case _DemoPage.toolbar:
        page = const StockholmToolbarDemoPage();
        break;
      case _DemoPage.colors:
        page = const StockholmColorDemoPage();
        break;
      case _DemoPage.textFields:
        page = const StockholmTextFieldDemoPage();
        break;
      case _DemoPage.propertyInspector:
        page = const StockholmPropertyInspectorDemoPage();
        break;
    }

    var colorOptionWidgets = <Widget>[];
    for (var themeColor in _ThemeColor.values) {
      colorOptionWidgets.add(
        StockholmToolbarButton(
          icon: Ionicons.square,
          color: _themeColorToStockholmColor(
            themeColor,
            appState.darkMode ? Brightness.dark : Brightness.light,
            appState.platform == _PlatformAppearance.macOS
                ? TargetPlatform.macOS
                : TargetPlatform.windows,
          ),
          height: 22.0,
          minWidth: 0.0,
          iconSize: 14.0,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          selected: appState.themeColor == themeColor,
          onPressed: () {
            setState(() {
              appState.themeColor = themeColor;
            });
          },
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          StockholmSideBar(
            width: 280,
            children: [
              const StockholmListTileHeader(child: Text('Controls')),
              StockholmListTile(
                leading: const Icon(Ionicons.toggle_outline),
                child: const Text('Buttons'),
                selected: _selectedPage == _DemoPage.buttons,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.buttons;
                  });
                },
              ),
              StockholmListTile(
                leading: const Icon(Ionicons.reader_outline),
                child: const Text('Menus'),
                selected: _selectedPage == _DemoPage.menus,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.menus;
                  });
                },
              ),
              StockholmListTile(
                leading: const Icon(Ionicons.text),
                child: const Text('Text fields'),
                selected: _selectedPage == _DemoPage.textFields,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.textFields;
                  });
                },
              ),
              const StockholmListTileHeader(child: Text('Layouts')),
              StockholmListTile(
                leading: const Icon(Ionicons.browsers_outline),
                child: const Text('Tables'),
                selected: _selectedPage == _DemoPage.tables,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.tables;
                  });
                },
              ),
              StockholmListTile(
                leading: const Icon(Ionicons.chatbubble_outline),
                child: const Text('Dialogs'),
                selected: _selectedPage == _DemoPage.dialogs,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.dialogs;
                  });
                },
              ),
              StockholmListTile(
                leading: const Icon(Ionicons.build_outline),
                child: const Text('Toolbars'),
                selected: _selectedPage == _DemoPage.toolbar,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.toolbar;
                  });
                },
              ),
              StockholmListTile(
                leading: const Icon(Ionicons.list_outline),
                child: const Text('Property inspector'),
                selected: _selectedPage == _DemoPage.propertyInspector,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.propertyInspector;
                  });
                },
              ),
              const StockholmListTileHeader(child: Text('Misc')),
              StockholmListTile(
                leading: const Icon(Ionicons.color_palette_outline),
                child: const Text('Colors'),
                selected: _selectedPage == _DemoPage.colors,
                onPressed: () {
                  setState(() {
                    _selectedPage = _DemoPage.colors;
                  });
                },
              ),
            ],
            footer: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StockholmToolbarButton(
                    height: 22,
                    icon: appState.darkMode
                        ? Ionicons.moon_outline
                        : Ionicons.sunny_outline,
                    onPressed: () {
                      setState(() {
                        appState.darkMode = !appState.darkMode;
                      });
                    },
                  ),
                  StockholmToolbarButton(
                    height: 22,
                    icon: appState.platform == _PlatformAppearance.windows
                        ? Icons.window_sharp
                        : MdiIcons.appleFinder,
                    onPressed: () {
                      setState(() {
                        var idx = appState.platform.index + 1;
                        if (idx >= _PlatformAppearance.values.length) {
                          idx = 0;
                        }
                        appState.platform = _PlatformAppearance.values[idx];
                      });
                    },
                  ),
                  const Spacer(),
                  ...colorOptionWidgets,
                ],
              ),
            ),
          ),
          Expanded(
            child: page,
          )
        ],
      ),
    );
  }
}

StockholmColor _themeColorToStockholmColor(
  _ThemeColor color,
  Brightness brightness,
  TargetPlatform platform,
) {
  var colors = StockholmColors.fromBrightness(brightness, platform);

  switch (color) {
    case _ThemeColor.blue:
      return colors.blue;
    case _ThemeColor.purple:
      return colors.purple;
    case _ThemeColor.pink:
      return colors.pink;
    case _ThemeColor.red:
      return colors.red;
    case _ThemeColor.orange:
      return colors.orange;
    case _ThemeColor.yellow:
      return colors.yellow;
    case _ThemeColor.green:
      return colors.green;
    case _ThemeColor.gray:
      return colors.gray;
  }
}
