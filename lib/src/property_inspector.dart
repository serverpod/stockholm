import 'package:flutter/material.dart';
import 'package:stockholm/src/checkbox.dart';

class StockholmPropertyInspector extends StatelessWidget {
  final StockholmPIHeader? header;
  final List<Widget> properties;

  static const defaultPropertyHeight = 24.0;
  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8.0);
  static const defaultDescriptionWidth = 80.0;

  StockholmPropertyInspector({
    this.header,
    required this.properties,
  });

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
}

class StockholmPIHeader extends StatelessWidget {
  final Widget child;

  StockholmPIHeader({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StockholmPropertyInspector.defaultPadding,
      height: StockholmPropertyInspector.defaultPropertyHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText1!,
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

  StockholmPIOneLineProp({
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StockholmPropertyInspector.defaultPadding,
      height: StockholmPropertyInspector.defaultPropertyHeight,
      child: Row(
        children: [
          SizedBox(
            width: StockholmPropertyInspector.defaultDescriptionWidth,
            child: Text(
              name,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
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

  StockholmPILargeProp({
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StockholmPropertyInspector.defaultPadding,
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
            padding: EdgeInsets.only(bottom: 8.0),
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

  StockholmPITextProp({
    required this.name,
    required this.value,
  });

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
  final List<String>? list;
  final double height;

  StockholmPIListProp({
    required this.name,
    required this.fallbackText,
    this.list,
    this.height = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget contents;
    if (list == null || list?.length == 0) {
      contents = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          fallbackText,
          style: Theme.of(context).textTheme.caption,
        ),
      );
    }
    else {
      contents = Container();
    }

    return StockholmPILargeProp(
      name: name,
      value: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 0.5, color: Theme.of(context).dividerColor),
        ),
        child: contents,
      ),
    );
  }
}

class StockholmPICheckboxProp extends StatelessWidget{
  final String name;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  StockholmPICheckboxProp({
    required this.name,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: StockholmCheckbox(
        value: value,
        onChanged: onChanged,
        label: name,
      ),
    );
  }
}


class StockholmPIDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 4.0,
      thickness: 0.5,
    );
  }
}

