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
        _BaseColorDemo(),
        _LightColorDemo(),
        _DarkColorDemo(),
        _ContrastColorDemo(),
      ],
    );
  }
}

class _BaseColorDemo extends StatelessWidget {
  const _BaseColorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = StockholmColors.fromContext(context);

    return DemoSection(
      title: 'Base colors',
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

class _LightColorDemo extends StatelessWidget {
  const _LightColorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = StockholmColors.fromContext(context);

    return DemoSection(
      title: 'Light colors',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ColorDisplay(color: colors.blue.light, outline: false),
          _ColorDisplay(color: colors.purple.light, outline: false),
          _ColorDisplay(color: colors.pink.light, outline: false),
          _ColorDisplay(color: colors.red.light, outline: false),
          _ColorDisplay(color: colors.orange.light, outline: false),
          _ColorDisplay(color: colors.yellow.light, outline: false),
          _ColorDisplay(color: colors.green.light, outline: false),
          _ColorDisplay(color: colors.gray.light, outline: false),
        ],
      ),
    );
  }
}

class _DarkColorDemo extends StatelessWidget {
  const _DarkColorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = StockholmColors.fromContext(context);

    return DemoSection(
      title: 'Dark colors',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ColorDisplay(color: colors.blue.dark, outline: false),
          _ColorDisplay(color: colors.purple.dark, outline: false),
          _ColorDisplay(color: colors.pink.dark, outline: false),
          _ColorDisplay(color: colors.red.dark, outline: false),
          _ColorDisplay(color: colors.orange.dark, outline: false),
          _ColorDisplay(color: colors.yellow.dark, outline: false),
          _ColorDisplay(color: colors.green.dark, outline: false),
          _ColorDisplay(color: colors.gray.dark, outline: false),
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
          _ColorDisplay(color: colors.blue.contrast, outline: true),
          _ColorDisplay(color: colors.purple.contrast, outline: true),
          _ColorDisplay(color: colors.pink.contrast, outline: true),
          _ColorDisplay(color: colors.red.contrast, outline: true),
          _ColorDisplay(color: colors.orange.contrast, outline: true),
          _ColorDisplay(color: colors.yellow.contrast, outline: true),
          _ColorDisplay(color: colors.green.contrast, outline: true),
          _ColorDisplay(color: colors.gray.contrast, outline: true),
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
