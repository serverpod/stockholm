import 'package:example/src/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

class StockholmButtonDemoPage extends StatelessWidget {
  const StockholmButtonDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StockholmDemoPage(children: [
      _NormalButtonsDemo(),
      _LargeButtonsDemo(),
      _CheckboxDemo(),
    ]);
  }
}

class _NormalButtonsDemo extends StatelessWidget {
  const _NormalButtonsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Buttons',
      child: Row(
        children: [
          StockholmButton(
            onPressed: () {},
            child: const Text('Regular Button'),
          ),
          const SizedBox(
            width: 8,
          ),
          StockholmButton(
            onPressed: () {},
            important: true,
            child: const Text('Important Button'),
          ),
          const SizedBox(
            width: 8,
          ),
          StockholmButton(
            onPressed: () {},
            enabled: false,
            child: const Text('Disabled Button'),
          ),
        ],
      ),
    );
  }
}

class _LargeButtonsDemo extends StatelessWidget {
  const _LargeButtonsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Large Buttons',
      child: Row(
        children: [
          StockholmButton(
            onPressed: () {},
            child: const Text('Regular Button'),
            large: true,
          ),
          const SizedBox(
            width: 8,
          ),
          StockholmButton(
            onPressed: () {},
            important: true,
            child: const Text('Important Button'),
            large: true,
          ),
          const SizedBox(
            width: 8,
          ),
          StockholmButton(
            onPressed: () {},
            enabled: false,
            child: const Text('Disabled Button'),
            large: true,
          ),
        ],
      ),
    );
  }
}

class _CheckboxDemo extends StatefulWidget {
  const _CheckboxDemo({Key? key}) : super(key: key);

  @override
  _CheckboxDemoState createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  bool _checkedFirst = false;
  bool _checkedSecond = true;

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Check boxes',
      child: Row(
        children: [
          StockholmCheckbox(
            value: _checkedFirst,
            label: 'Initially unchecked',
            onChanged: (bool value) {
              setState(() {
                _checkedFirst = value;
              });
            },
          ),
          const SizedBox(
            width: 16,
          ),
          StockholmCheckbox(
            value: _checkedSecond,
            label: 'Initially checked',
            onChanged: (bool value) {
              setState(() {
                _checkedSecond = value;
              });
            },
          ),
          const SizedBox(
            width: 16,
          ),
          const StockholmCheckbox(
            value: false,
            label: 'Disabled unchecked',
          ),
          const SizedBox(
            width: 16,
          ),
          const StockholmCheckbox(
            value: true,
            label: 'Disabled checked',
          ),
        ],
      ),
    );
  }
}
