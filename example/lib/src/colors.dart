import 'package:example/src/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stockholm/stockholm.dart';

class StockholmColorDemoPage extends StatelessWidget {
  const StockholmColorDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StockholmDemoPage(
      children: [
        _SolidColorDemo(),
        _ContrastColorDemo(),
      ],
    );
  }
}

class _SolidColorDemo extends StatelessWidget {
  const _SolidColorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = StockholmColors.fromContext(context);

    return DemoSection(
      title: 'Colors',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ColorDisplay(color: colors.blue, outline: false),
          _ColorDisplay(color: colors.purple, outline: false),
          _ColorDisplay(color: colors.pink, outline: false),
          _ColorDisplay(color: colors.red, outline: false),
          _ColorDisplay(color: colors.orange, outline: false),
          _ColorDisplay(color: colors.yellow, outline: false),
          _ColorDisplay(color: colors.green, outline: false),
          _ColorDisplay(color: colors.gray, outline: false),
        ],
      ),
    );
  }
}

class _ContrastColorDemo extends StatelessWidget {
  const _ContrastColorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = StockholmColors.fromContext(context);

    return DemoSection(
      title: 'High contrast colors',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ColorDisplay(color: colors.blueContrast, outline: true),
          _ColorDisplay(color: colors.purpleContrast, outline: true),
          _ColorDisplay(color: colors.pinkContrast, outline: true),
          _ColorDisplay(color: colors.redContrast, outline: true),
          _ColorDisplay(color: colors.orangeContrast, outline: true),
          _ColorDisplay(color: colors.yellowContrast, outline: true),
          _ColorDisplay(color: colors.greenContrast, outline: true),
          _ColorDisplay(color: colors.grayContrast, outline: true),
        ],
      ),
    );
  }
}

class _ColorDisplay extends StatelessWidget {
  const _ColorDisplay({
    required this.color,
    required this.outline,
    Key? key,
  }) : super(key: key);

  final Color color;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Icon(
        outline ? Ionicons.square_outline : Ionicons.square,
        color: color,
        size: 16,
      ),
    );
  }
}
