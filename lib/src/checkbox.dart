import 'package:flutter/material.dart';
import 'shadows.dart';

class StockholmCheckbox extends StatefulWidget {
  bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final size;
  final double cornerRadius;

  StockholmCheckbox({
    required this.value,
    this.onChanged,
    this.label,
    this.size = 16.0,
    this.cornerRadius = 4.0,
  });

  @override
  _StockholmCheckboxState createState() => _StockholmCheckboxState();
}

class _StockholmCheckboxState extends State<StockholmCheckbox> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    Widget visual;
    if (widget.value) {
      var color = Theme.of(context).indicatorColor;
      if (_pressed)
        color = Color.lerp(color, Colors.black, 0.2)!;

      visual = Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.cornerRadius)),
          color: color,
          boxShadow: stockholmBoxShadow(context),
        ),
        child: Icon(
          Icons.check,
          size: widget.size,
          color: Theme.of(context).cardColor,
        ),
      );
    }
    else {
      var color = Theme.of(context).cardColor;
      if (_pressed)
        color = Color.lerp(color, Colors.black, 0.2)!;

      visual = Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.cornerRadius)),
          color: color,
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
          boxShadow: stockholmBoxShadow(context),
        ),
      );
    }

    if (widget.label != null) {
      visual = Row(
        children: [
          visual,
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      );
    }

    if (widget.onChanged == null)
      return visual;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onChanged!(!widget.value);
      },
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
      },
      child: visual,
    );
  }
}
