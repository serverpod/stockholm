import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockholm/src/checkbox.dart';
import 'package:stockholm/src/text_field.dart';

class StockholmPropertyInspector extends StatelessWidget {
  final StockholmPIHeader? header;
  final List<Widget> properties;
  final double descriptionWidth;
  final EdgeInsets propertyPadding;

  static const defaultPropertyHeight = 32.0;
  static const defaultPropertyPadding = EdgeInsets.symmetric(horizontal: 8.0);
  static const defaultDescriptionWidth = 80.0;

  const StockholmPropertyInspector({
    this.header,
    required this.properties,
    this.descriptionWidth = defaultDescriptionWidth,
    this.propertyPadding = defaultPropertyPadding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (header != null) header!,
        Expanded(
          child: ListView(
            children: properties,
          ),
        ),
      ],
    );
  }

  static StockholmPropertyInspector? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<StockholmPropertyInspector>();
  }
}

class StockholmPIHeader extends StatelessWidget {
  final Widget child;

  const StockholmPIHeader({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = StockholmPropertyInspector.of(context)?.propertyPadding ??
        StockholmPropertyInspector.defaultPropertyPadding;
    return Container(
      padding: padding,
      height: 24, // StockholmPropertyInspector.defaultPropertyHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subtitle2!,
        child: Align(
          alignment: Alignment.centerLeft,
          child: child,
        ),
      ),
    );
  }
}

class StockholmPIOneLineProp extends StatelessWidget {
  final String name;
  final Widget value;
  final TextAlign nameAlignment;

  const StockholmPIOneLineProp({
    required this.name,
    required this.value,
    this.nameAlignment = TextAlign.end,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inspector = StockholmPropertyInspector.of(context);
    var descriptionWidth = inspector?.descriptionWidth ??
        StockholmPropertyInspector.defaultDescriptionWidth;
    var padding = inspector?.propertyPadding ??
        StockholmPropertyInspector.defaultPropertyPadding;

    return Container(
      padding: padding,
      height: StockholmPropertyInspector.defaultPropertyHeight,
      child: Row(
        children: [
          SizedBox(
            width: descriptionWidth,
            child: Text(
              name,
              textAlign: nameAlignment,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: value,
            ),
          ),
        ],
      ),
    );
  }
}

class StockholmPILargeProp extends StatelessWidget {
  final String name;
  final Widget value;

  const StockholmPILargeProp({
    required this.name,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inspector = StockholmPropertyInspector.of(context);
    var padding = inspector?.propertyPadding ??
        StockholmPropertyInspector.defaultPropertyPadding;

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: StockholmPropertyInspector.defaultPropertyHeight,
            width: StockholmPropertyInspector.defaultDescriptionWidth,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: value,
          ),
        ],
      ),
    );
  }
}

class StockholmPITextProp extends StatelessWidget {
  final String name;
  final String value;

  const StockholmPITextProp({
    required this.name,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StockholmPIOneLineProp(
      name: name,
      value: Text(value),
    );
  }
}

class StockholmPIListProp extends StatelessWidget {
  final String name;
  final String fallbackText;
  final List<Widget>? list;
  final double height;

  const StockholmPIListProp({
    required this.name,
    required this.fallbackText,
    this.list,
    this.height = 200.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contents;
    if (list == null || list!.isEmpty) {
      contents = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          fallbackText,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      );
    } else {
      contents = ListView.builder(
        itemCount: list!.length,
        itemBuilder: (context, idx) => list![idx],
      );
    }

    return StockholmPILargeProp(
      name: name,
      value: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 0.5, color: Theme.of(context).dividerColor),
        ),
        child: contents,
      ),
    );
  }
}

class StockholmPICheckboxProp extends StatelessWidget {
  final String name;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  const StockholmPICheckboxProp({
    required this.name,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inspector = StockholmPropertyInspector.of(context);
    var padding = inspector?.propertyPadding ??
        StockholmPropertyInspector.defaultPropertyPadding;

    return SizedBox(
      height: StockholmPropertyInspector.defaultPropertyHeight,
      child: Padding(
        padding: padding,
        child: StockholmCheckbox(
          value: value,
          onChanged: onChanged,
          label: name,
        ),
      ),
    );
  }
}

class StockholmPIEditableIntProp extends StatefulWidget {
  final String name;
  final int value;
  final ValueChanged<int>? onChanged;
  final TextAlign nameAlignment;

  const StockholmPIEditableIntProp({
    required this.name,
    required this.value,
    required this.onChanged,
    this.nameAlignment = TextAlign.end,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StockholmPIEditableIntPropState();
}

class StockholmPIEditableIntPropState
    extends State<StockholmPIEditableIntProp> {
  late TextEditingController _controller;

  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _controller = TextEditingController(text: '${widget.value}');
    _controller.addListener(() {
      var newValue = int.tryParse(_controller.text);
      if (newValue != null && newValue != _value) {
        _value = newValue;
        if (widget.onChanged != null) widget.onChanged!(_value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StockholmPIOneLineProp(
      nameAlignment: widget.nameAlignment,
      name: widget.name,
      value: StockholmTextField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.end,
      ),
    );
  }
}

class StockholmPIDivider extends StatelessWidget {
  const StockholmPIDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 4.0,
      thickness: 0.5,
    );
  }
}
