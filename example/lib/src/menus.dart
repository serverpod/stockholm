import 'package:example/src/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

class StockholmMenuDemoPage extends StatelessWidget {
  const StockholmMenuDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StockholmDemoPage(children: [
      _PopupButtonsDemo(),
      _TestButtonDemo(),
      _DropdownButtonsDemo(),
    ]);
  }
}

class _DropdownButtonsDemo extends StatefulWidget {
  const _DropdownButtonsDemo({Key? key}) : super(key: key);

  @override
  __DropdownButtonsDemoState createState() => __DropdownButtonsDemoState();
}

class __DropdownButtonsDemoState extends State<_DropdownButtonsDemo> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Dropdown buttons',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: 200,
            child: StockholmDropdownButton<int>(
              width: 150,
              items: const [
                StockholmDropdownItem<int>(value: 0, child: Text('Item 0')),
                StockholmDropdownItem<int>(value: 1, child: Text('Item 1')),
                StockholmDropdownItem<int>(value: 2, child: Text('Item 2')),
                StockholmDropdownItem<int>(value: 3, child: Text('Item 3')),
                StockholmDropdownItem<int>(value: 4, child: Text('Item 4')),
              ],
              value: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
          ),
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
