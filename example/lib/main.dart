import 'package:example/src/buttons.dart';
import 'package:example/src/colors.dart';
import 'package:example/src/dialogs.dart';
import 'package:example/src/menus.dart';
import 'package:example/src/tables.dart';
import 'package:example/src/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stockholm/stockholm.dart';

enum _DemoPage {
  buttons,
  menus,
  tables,
  dialogs,
  toolbar,
  colors,
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

  bool get darkMode => _darkMode;

  set darkMode(bool darkMode) {
    setState(() {
      _darkMode = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stockholm Demo',
      theme: _darkMode ? StockholmThemeData.dark() : StockholmThemeData.light(),
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
    }

    return Scaffold(
      body: Row(
        children: [
          StockholmSideBar(
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
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  StockholmToolbarButton(
                    icon: appState.darkMode
                        ? Ionicons.moon_outline
                        : Ionicons.sunny_outline,
                    onPressed: () {
                      setState(() {
                        appState.darkMode = !appState.darkMode;
                      });
                    },
                  ),
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
