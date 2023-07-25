import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StockholmTextField extends StatefulWidget {
  const StockholmTextField({
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign,
    this.autofocus = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFocusChange,
    this.onSubmitted,
    this.placeholder,
    this.enabled = true,
    this.obscureText = false,
    this.expands = false,
    this.maxLength,
    this.drawBorder = true,
    this.padding = const EdgeInsets.all(7),
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final bool autofocus;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final void Function(bool)? onFocusChange;
  final String? placeholder;
  final bool enabled;
  final bool obscureText;
  final bool expands;
  final int? maxLength;
  final bool drawBorder;
  final EdgeInsets padding;

  @override
  State<StockholmTextField> createState() => _StockholmTextFieldState();
}

class _StockholmTextFieldState extends State<StockholmTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.onFocusChange != null) {
        widget.onFocusChange!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textField = widget.drawBorder
        ? CupertinoTextField(
            style: Theme.of(context).textTheme.bodyMedium,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign ?? TextAlign.start,
            autofocus: widget.autofocus,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            placeholder: widget.placeholder,
            enabled: widget.enabled,
            obscureText: widget.obscureText,
            expands: widget.expands,
            maxLength: widget.maxLength,
            padding: widget.padding,
            focusNode: _focusNode,
          )
        : CupertinoTextField(
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: null,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign ?? TextAlign.start,
            autofocus: widget.autofocus,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            placeholder: widget.placeholder,
            enabled: widget.enabled,
            obscureText: widget.obscureText,
            expands: widget.expands,
            maxLength: widget.maxLength,
            padding: widget.padding,
            focusNode: _focusNode,
          );

    return textField;
  }
}
