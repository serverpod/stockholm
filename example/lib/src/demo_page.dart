import 'package:flutter/material.dart';

class StockholmDemoPage extends StatelessWidget {
  const StockholmDemoPage({
    required this.children,
    this.padding = const EdgeInsets.only(left: 16, right: 16, top: 8),
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      children: children,
    );
  }
}

class DemoSection extends StatelessWidget {
  const DemoSection({
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: 8,
        ),
        child,
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
