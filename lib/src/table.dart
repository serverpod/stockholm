import 'package:flutter/material.dart';

const _cellHeight = 24.0;
const _cellWidth = 90.0;
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

  @override
  _StockholmTableState createState() => _StockholmTableState();
}

class _StockholmTableState extends State<StockholmTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  int? _selectedRow;

  @override
  void initState() {
    super.initState();
    _selectedRow = widget.selectedRow;
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

    return Scrollbar(
      controller: _horizontalController,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: SingleChildScrollView(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _cellWidth * widget.columnCount + _horizontalRowPadding * 2,
          child: Column(
            children: [
              _TableHeader(
                decoration: widget.headerDecoration,
                cells: widget.headerBuilder(context),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    itemCount: widget.rowCount,
                    controller: _verticalController,
                    itemBuilder: (context, row) {
                      return _TableRow(
                        cells: widget.rowBuilder(context, row, false),
                        selected: _selectedRow == row,
                        backgroundColor: row % 2 == 1 ? altBgColor : null,
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
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.cells,
    required this.decoration,
    Key? key,
  }) : super(key: key);

  final List<Widget> cells;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
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
        children: cells
            .map((e) => SizedBox(
                  width: _cellWidth,
                  height: _headerHeight,
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!,
                    child: e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.cells,
    required this.onPressed,
    required this.selected,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final List<Widget> cells;
  final VoidCallback onPressed;
  final bool selected;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _horizontalRowPadding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: selected ? Theme.of(context).primaryColor : backgroundColor,
        ),
        child: Row(
          children: cells
              .map(
                (e) => SizedBox(
                  width: _cellWidth,
                  height: _cellHeight,
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: selected ? Colors.white : null,
                        ),
                    child: e,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class StockholmTableCell extends StatelessWidget {
  const StockholmTableCell({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }
}

class StockholmTableHeaderCell extends StatelessWidget {
  const StockholmTableHeaderCell({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }
}
