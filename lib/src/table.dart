import 'package:flutter/material.dart';

const _headerHeight = 24.0;
const _horizontalRowPadding = 8.0;

class StockholmTable extends StatefulWidget {
  const StockholmTable({
    required this.headerBuilder,
    required this.rowBuilder,
    required this.rowCount,
    required this.columnCount,
    required this.columnWidths,
    this.backgroundColor,
    this.altBackgroundColor,
    this.headerDecoration,
    this.selectedRow,
    this.selectableRows = true,
    this.onSelectedRow,
    this.cellHeight = 24.0,
    Key? key,
  }) : super(key: key);

  final List<Widget> Function(BuildContext context) headerBuilder;
  final List<Widget> Function(BuildContext context, int row, bool selected)
      rowBuilder;
  final List<double> columnWidths;
  final int rowCount;
  final int columnCount;
  final Color? backgroundColor;
  final Color? altBackgroundColor;
  final BoxDecoration? headerDecoration;
  final int? selectedRow;
  final bool selectableRows;
  final ValueChanged<int?>? onSelectedRow;
  final double cellHeight;

  @override
  _StockholmTableState createState() => _StockholmTableState();
}

class _StockholmTableState extends State<StockholmTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  int? _selectedRow;
  late final double _totalColumnWidths;

  @override
  void initState() {
    super.initState();
    _selectedRow = widget.selectedRow;
    _totalColumnWidths = widget.columnWidths.fold(0, (prev, e) => prev + e);
  }

  @override
  void dispose() {
    super.dispose();
    _horizontalController.dispose();
    _verticalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var altBgColor =
        widget.altBackgroundColor ?? Theme.of(context).selectedRowColor;

    return LayoutBuilder(builder: (context, constraints) {
      double _totalColumnSpace =
          constraints.maxWidth - _horizontalRowPadding * 2;
      bool hasHorizontalOverflow = _totalColumnWidths > _totalColumnSpace;

      List<double> calcWidths;
      double calcTotalWidth;

      if (hasHorizontalOverflow) {
        calcWidths = widget.columnWidths;
        calcTotalWidth = _totalColumnWidths;
      } else {
        calcWidths = widget.columnWidths
            .map(
              (e) => (e * _totalColumnSpace / _totalColumnWidths)
                  .floor()
                  .toDouble(),
            )
            .toList();
        calcTotalWidth = _totalColumnSpace;
      }

      return Scrollbar(
        controller: _horizontalController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: calcTotalWidth + _horizontalRowPadding * 2,
            child: Column(
              children: [
                _TableHeader(
                  widths: calcWidths,
                  decoration: widget.headerDecoration,
                  cells: widget.headerBuilder(context),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: !hasHorizontalOverflow,
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: widget.rowCount,
                      controller: _verticalController,
                      prototypeItem: SizedBox(
                        width: calcTotalWidth + _horizontalRowPadding * 2,
                        height: widget.cellHeight,
                      ),
                      itemBuilder: (context, row) {
                        return _TableRow(
                          cells: widget.rowBuilder(context, row, false),
                          widths: calcWidths,
                          height: widget.cellHeight,
                          selected: _selectedRow == row,
                          backgroundColor: row % 2 == 1 ? altBgColor : null,
                          hasHorizontalOverflow: hasHorizontalOverflow,
                          onPressed: () {
                            if (widget.selectableRows) {
                              setState(() {
                                _selectedRow = row;
                              });
                              if (widget.onSelectedRow != null) {
                                widget.onSelectedRow!(row);
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.cells,
    required this.widths,
    required this.decoration,
    Key? key,
  }) : super(key: key);

  final List<Widget> cells;
  final List<double> widths;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    var cellWidgets = <Widget>[];
    int i = 0;
    for (var cell in cells) {
      cellWidgets.add(
        SizedBox(
          width: widths[i],
          height: _headerHeight,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.subtitle2!,
            child: cell,
          ),
        ),
      );
      i += 1;
    }

    return Container(
      decoration: decoration ??
          BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
            ),
            color: Theme.of(context).backgroundColor,
          ),
      padding: const EdgeInsets.symmetric(horizontal: _horizontalRowPadding),
      child: Row(
        children: cellWidgets,
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.cells,
    required this.onPressed,
    required this.selected,
    required this.hasHorizontalOverflow,
    required this.widths,
    required this.height,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final List<Widget> cells;
  final VoidCallback onPressed;
  final bool selected;
  final bool hasHorizontalOverflow;
  final Color? backgroundColor;
  final List<double> widths;
  final double height;

  @override
  Widget build(BuildContext context) {
    var cellWidgets = <Widget>[];
    int i = 0;
    for (var cell in cells) {
      cellWidgets.add(
        SizedBox(
          width: widths[i],
          height: height,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: selected ? Colors.white : null,
                ),
            child: cell,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: hasHorizontalOverflow ? 0.0 : _horizontalRowPadding,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: hasHorizontalOverflow ? _horizontalRowPadding : 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: hasHorizontalOverflow
              ? null
              : const BorderRadius.all(Radius.circular(4)),
          color: selected ? Theme.of(context).primaryColor : backgroundColor,
        ),
        child: Row(
          children: cellWidgets,
        ),
      ),
    );
  }
}

class StockholmTableCell extends StatelessWidget {
  const StockholmTableCell({
    required this.child,
    this.alignment = Alignment.centerLeft,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: child,
    );
  }
}

class StockholmTableHeaderCell extends StatelessWidget {
  const StockholmTableHeaderCell({
    required this.child,
    this.alignment = Alignment.centerLeft,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: child,
    );
  }
}
