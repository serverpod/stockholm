import 'package:flutter/material.dart';
import 'package:stockholm/src/dialog.dart';

class StockholmProgressDialog extends StatefulWidget {
  const StockholmProgressDialog({
    required this.title,
    required this.controller,
    super.key,
  });

  final StockholmProgressDialogController controller;

  final Widget title;

  @override
  State<StockholmProgressDialog> createState() =>
      StockholmProgressDialogState();
}

class StockholmProgressDialogState extends State<StockholmProgressDialog> {
  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
  }

  @override
  void dispose() {
    widget.controller._state = null;
    super.dispose();
  }

  String get progressMessage => widget.controller.progressMessage;

  @override
  Widget build(BuildContext context) {
    return StockholmDialog(
      title: widget.title,
      contents: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text(
              widget.controller.progressMessage,
            ),
          ],
        ),
      ),
    );
  }

  void close() {
    Navigator.of(context).pop();
  }

  void _controllerUpdated() {
    setState(() {});
  }
}

void showStockholmProgressDialog({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: builder,
  );
}

class StockholmProgressDialogController {
  StockholmProgressDialogController({
    required String progressMessage,
  }) : _progressMessage = progressMessage;

  StockholmProgressDialogState? _state;

  String _progressMessage;
  String get progressMessage => _progressMessage;
  set progressMessage(String value) {
    _progressMessage = value;
    _state?._controllerUpdated();
  }

  void close() {
    _state?.close();
  }
}
