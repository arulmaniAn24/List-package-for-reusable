import 'package:flutter/material.dart';
import '../models/list_item.dart';

class TableView extends StatelessWidget {
  final List<ListItem> items;
  final List<String> columns;

  TableView({required this.items, required this.columns});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns.map((column) => DataColumn(label: Text(column))).toList(),
        rows: items.map((item) {
          return DataRow(
            cells: columns.map((column) {
              return DataCell(Text('${item.fields[column]}'));
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
