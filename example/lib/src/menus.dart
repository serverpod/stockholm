import 'package:example/src/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

class StockholmMenuDemoPage extends StatelessWidget {
  const StockholmMenuDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StockholmDemoPage(children: [
      _DropdownButtonsDemo(),
      _PopupButtonsDemo(),
      _TestButtonDemo(),
    ]);
  }
}

class _DropdownButtonsDemo extends StatelessWidget {
  const _DropdownButtonsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Dropdown buttons',
      child: Row(
        children: [
          StockholmDropdownButton(items: [
            DropdownMenuItem(child: Text('Item 1')),
            DropdownMenuItem(child: Text('Item 2')),
            DropdownMenuItem(child: Text('Item 3')),
            DropdownMenuItem(child: Text('Item 4')),
          ]),
        ],
      ),
    );
  }
}

class _PopupButtonsDemo extends StatelessWidget {
  const _PopupButtonsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Popup menu buttons',
      child: Row(
        children: [
          StockholmPopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Item 1'),
              ),
              PopupMenuItem(
                child: Text('Item 2'),
              ),
              PopupMenuItem(
                child: Text('Item 3'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TestButtonDemo extends StatelessWidget {
  const _TestButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Test  button',
      child: TestButton(),
    );
  }
}
