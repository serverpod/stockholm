import 'package:example/src/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

class StockholmToolbarDemoPage extends StatelessWidget {
  const StockholmToolbarDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StockholmDemoPage(children: [
      _NormalButtonsDemo(),
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
