import 'package:flutter/material.dart';
import 'package:stockholm/src/button.dart';
import 'package:stockholm/src/popup_menu_button.dart';

class StockholmDropdownButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Offset? offset;
  final T? value;
  final bool isExpanded;
  final Widget? icon;

  const StockholmDropdownButton({
    required this.items,
    this.onChanged,
    this.value,
    this.offset,
    this.isExpanded = false,
    this.icon = const Icon(
      Icons.expand_more,
      size: 16,
    ),
    Key? key,
  }) : super(key: key);

  @override
  _StockholmDropdownButtonState<T> createState() =>
      _StockholmDropdownButtonState<T>();
}

class _StockholmDropdownButtonState<T>
    extends State<StockholmDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    // DropdownMenuItem<T>? selectedItem;
    var selectedItem =
        widget.items.firstWhere((element) => element.value == widget.value);

    var child = selectedItem.child;
    if (widget.isExpanded) {
      child = Expanded(
        child: child,
      );
    }

    return StockholmPopupMenuButton(
      offset: widget.offset ?? Offset.zero,
      itemBuilder: (context) {
        var items = <StockholmPopupMenuItem<T>>[];
        for (var item in widget.items) {
          items.add(
            StockholmPopupMenuItem<T>(
              child: item.child,
              value: item.value,
              onTap: () {
                if (widget.onChanged != null) widget.onChanged!(item.value);
              },
            ),
          );
        }
        return items;
      },
      child: IgnorePointer(
        child: StockholmButton(
          padding: EdgeInsets.only(
            left: 12,
            right: widget.icon == null ? 12 : 8,
            top: 4,
            bottom: 4,
          ),
          child: Row(
            children: [
              child,
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: widget.icon,
                ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
