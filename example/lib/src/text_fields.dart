import 'package:example/src/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

class StockholmTextFieldDemoPage extends StatelessWidget {
  const StockholmTextFieldDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StockholmDemoPage(children: [
      _TextFieldDemo(),
      _DateTimePickerDemo(),
    ]);
  }
}

class _TextFieldDemo extends StatelessWidget {
  const _TextFieldDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DemoSection(
      title: 'Text fields',
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: StockholmTextField(
              autofocus: true,
            ),
          )
        ],
      ),
    );
  }
}

class _DateTimePickerDemo extends StatefulWidget {
  const _DateTimePickerDemo({Key? key}) : super(key: key);

  @override
  State<_DateTimePickerDemo> createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<_DateTimePickerDemo> {
  var _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DemoSection(
      title: 'Date time picker',
      child: SizedBox(
        width: 200,
        child: StockholmDateTimePicker(
          dateTime: _dateTime,
          onChanged: (value) {
            setState(() {
              _dateTime = value;
            });
          },
        ),
      ),
    );
  }
}
