import 'package:flutter/material.dart';
import 'package:stockholm/src/button.dart';
import 'package:stockholm/src/popup_menu_button.dart';

class StockholmDropdownButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Offset? offset;
  final T? value;

  const StockholmDropdownButton({
    required this.items,
    this.onChanged,
    this.value,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  _StockholmDropdownButtonState<T> createState() => _StockholmDropdownButtonState<T>();
}

class _StockholmDropdownButtonState<T> extends State<StockholmDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    // DropdownMenuItem<T>? selectedItem;
    var selectedItem = widget.items.firstWhere((element) => element.value == widget.value);

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
                if (widget.onChanged != null)
                  widget.onChanged!(item.value);
              },
            ),
          );
        }
        return items;
      },
      child: IgnorePointer(
        child: StockholmButton(child: selectedItem.child, onPressed: () {},),
      ),
    );
  }
}

//
// class StockholmDropdownButton<T> extends StatelessWidget {
//   final List<DropdownMenuItem<T>> items;
//   final ValueChanged<T?>? onChanged;
//   final T? value;
//
//   const StockholmDropdownButton({
//     required this.items,
//     this.onChanged,
//     this.value,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8,),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         border: Border.all(color: Theme.of(context).dividerColor, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black54,
//             blurRadius: 2,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: DropdownButton<T>(
//         items: items,
//         onChanged: onChanged,
//         value: value,
//         underline: SizedBox(),
//         isDense: true,
//         // itemHeight: 24,
//         // menuMaxHeight: 24,
//       ),
//     );
//   }
// }
