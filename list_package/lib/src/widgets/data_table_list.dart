// lib/widgets/data_table_list.dart

import 'package:flutter/material.dart';

import '../models/data_item.dart';

class DataTableList<T> extends StatelessWidget {
  final List<DataItem<T>> data;
  final List<DataColumn> columns;
  final List<DataCell> Function(DataItem<T>) rowBuilder;

  DataTableList({
    Key? key,
    required this.data,
    required this.columns,
    required this.rowBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: columns,
        rows: data.map((dataItem) {
          return DataRow(cells: rowBuilder(dataItem));
        }).toList(),
      ),
    );
  }
}
