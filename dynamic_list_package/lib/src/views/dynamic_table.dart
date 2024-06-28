import 'package:flutter/material.dart';
import '../models/list_item.dart';

class TableView extends StatefulWidget {
  final List<ListItem> items;
  final List<String> columns;

  TableView({required this.items, required this.columns});

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  int rowsPerPage = 10;
  int currentPage = 1;

  List<ListItem> get currentPageItems {
    final startIndex = (currentPage - 1) * rowsPerPage;
    final endIndex = startIndex + rowsPerPage;
    return widget.items
        .sublist(startIndex, endIndex.clamp(0, widget.items.length));
  }

  int get totalPages => (widget.items.length / rowsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20.0,
              columns: [
                ...widget.columns
                    .map((column) => DataColumn(label: Text(column))),
                DataColumn(label: Text('Actions')), // Add actions column
              ],
              rows: currentPageItems.map((item) {
                return DataRow(
                  cells: [
                    ...widget.columns.map((column) {
                      return DataCell(Container(
                        width: MediaQuery.of(context).size.width /
                            widget.columns.length,
                        child: Text('${item.fields[column]}'),
                      ));
                    }).toList(),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle edit action here
                            // Example: navigate to edit screen
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete action here
                            // Example: show delete confirmation dialog
                          },
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Rows per page: '),
              DropdownButton<int>(
                value: rowsPerPage,
                onChanged: (value) {
                  setState(() {
                    rowsPerPage = value!;
                    currentPage = 1;
                  });
                },
                items:
                    [10, 20, 50, 100].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
              ),
              SizedBox(width: 20),
              Text('Page: $currentPage of $totalPages'),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: currentPage > 1
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: currentPage < totalPages
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
