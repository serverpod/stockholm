import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class StockholmExpansionTile extends StatefulWidget {
  const StockholmExpansionTile({
    required this.title,
    this.children = const [],
    this.expandedCrossAxisAlignment,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final List<Widget> children;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final bool initiallyExpanded;
  final void Function(bool)? onExpansionChanged;

  @override
  State<StatefulWidget> createState() => StockholmExpansionTileState();
}

class StockholmExpansionTileState extends State<StockholmExpansionTile> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var tileTheme = theme.copyWith(
      listTileTheme: const ListTileThemeData(
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        visualDensity: VisualDensity.compact,
      ),
    );

    return Theme(
      data: tileTheme,
      child: ExpansionTile(
        title: widget.title,
        children: widget.children,
        expandedCrossAxisAlignment: widget.expandedCrossAxisAlignment,
        initiallyExpanded: widget.initiallyExpanded,
        trailing: const SizedBox(),
        tilePadding: EdgeInsets.zero,
        leading: SizedBox(
          width: 20,
          height: 16,
          child: Center(
            child: Icon(
              _expanded ? Ionicons.caret_down : Ionicons.caret_forward,
              size: 12,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _expanded = expanded;
          });
          widget.onExpansionChanged?.call(expanded);
        },
      ),
    );
  }
}
