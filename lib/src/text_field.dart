import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StockholmTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final bool autofocus;
  final void Function(String?)? onChanged;
  final String? placeholder;
  final bool enabled;
  final bool obscureText;
  final bool expands;

  const StockholmTextField({
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign,
    this.autofocus = false,
    this.onChanged,
    this.placeholder,
    this.enabled = true,
    this.obscureText = false,
    this.expands = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      autofocus: autofocus,
      onChanged: onChanged,
      placeholder: placeholder,
      enabled: enabled,
      obscureText: obscureText,
      expands: expands,
    );
  }
}
