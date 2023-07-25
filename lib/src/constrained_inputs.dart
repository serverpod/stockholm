import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockholm/stockholm.dart';

class StockholmBoolInput extends StatelessWidget {
  const StockholmBoolInput({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return StockholmDropdownButton<bool>(
      items: const [
        StockholmDropdownItem(
          value: true,
          child: Text('true'),
        ),
        StockholmDropdownItem(
          value: false,
          child: Text('false'),
        ),
      ],
      onChanged: onChanged,
      value: value,
    );
  }
}

class StockholmIntInput extends StatefulWidget {
  const StockholmIntInput({
    required this.value,
    required this.onChanged,
    this.onFocusChange,
    this.onFilled,
    this.textAlign = TextAlign.end,
    this.maxLength,
    this.drawBorder = true,
    this.padding = const EdgeInsets.all(7),
    this.padValue = false,
    this.selectAllOnFocus = false,
    super.key,
  });

  final int value;
  final int? maxLength;
  final ValueChanged<int>? onChanged;
  final ValueChanged<bool>? onFocusChange;
  final VoidCallback? onFilled;
  final TextAlign textAlign;
  final bool drawBorder;
  final EdgeInsets padding;
  final bool padValue;
  final bool selectAllOnFocus;

  @override
  State<StockholmIntInput> createState() => _StockholmIntInputState();
}

class _StockholmIntInputState extends State<StockholmIntInput> {
  late TextEditingController _controller;
  late int _value;
  late String _oldText;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _controller = TextEditingController();
    _updateText(widget.value);
    _oldText = _controller.text;

    _controller.addListener(() {
      var newValue = int.tryParse(_controller.text);
      if (newValue != null && newValue != _value) {
        _value = newValue;
        if (widget.onChanged != null) widget.onChanged!(_value);

        if (_controller.text != _oldText) {
          if (widget.maxLength != null &&
              _controller.text.length >= widget.maxLength!) {
            if (widget.onFilled != null) widget.onFilled!();
          }

          _oldText = _controller.text;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StockholmTextField(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          // Gained focus, select all text.
          if (widget.selectAllOnFocus) {
            _controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controller.text.length,
            );
          }
        } else {
          // Lost focus, update text to make sure it's padded.
          _updateText(_value);
        }
        widget.onFocusChange?.call(hasFocus);
      },
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(),
      drawBorder: widget.drawBorder,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      padding: widget.padding,
    );
  }

  @override
  void didUpdateWidget(covariant StockholmIntInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _value) {
      _value = widget.value;
      _updateText(_value);
    }
  }

  void _updateText(int value) {
    var text = '$value';
    if (widget.padValue && widget.maxLength != null) {
      text = text.padLeft(widget.maxLength!, '0');
    }
    _controller.text = text;
  }
}
