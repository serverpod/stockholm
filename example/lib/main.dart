import 'package:example/src/buttons.dart';
import 'package:example/src/menus.dart';
import 'package:example/src/tables.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stockholm/stockholm.dart';

enum _DemoPage {
  buttons,
  menus,
  tables,
}

void main() {
  runApp(const StockholmDemoApp());
}

class StockholmDemoApp extends StatelessWidget {
  const StockholmDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stockholm Demo',
      theme: StockholmThemeData.light(),
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
            ],
          ),
          Expanded(
            child: page,
          )
        ],
      ),
    );
  }
}
