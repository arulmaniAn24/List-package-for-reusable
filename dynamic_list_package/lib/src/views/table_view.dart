import 'package:flutter/material.dart';
import '../models/list_item.dart';

class TableView extends StatefulWidget {
  final List<ListItem> items;
  final List<String> columns;

  const TableView({required this.items, required this.columns});

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
    final Color tableHeadingColor = const Color(0xFF3C3D43);
    final Color columnsColor = const Color(0xFF727272);
    final Color headingRowColor = const Color(0xFFE9EBF2);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              DataTable(
                dataRowHeight: 60.0,
                columnSpacing: 20.0,
                headingRowHeight: 70.0,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => headingRowColor),
                headingTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: tableHeadingColor,
                ),
                columns: [
                  DataColumn(label: Text('Avatar')),
                  ...widget.columns
                      .sublist(1)
                      .map((column) => DataColumn(label: Text(column))),
                  DataColumn(label: const Text('Actions')),
                ],
                rows: currentPageItems.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFF1F397A),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ...widget.columns.sublist(1).map((column) {
                        return DataCell(
                          Text(
                            '${item.fields[column]}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: Color(0xFF727272),
                            ),
                          ),
                        );
                      }).toList(),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _editItem(context, item.fields);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteItem(context, item);
                            },
                          ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Rows per page: ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xFF727272),
                    ),
                  ),
                  DropdownButton<int>(
                    value: rowsPerPage,
                    onChanged: (value) {
                      setState(() {
                        rowsPerPage = value!;
                        currentPage = 1;
                      });
                    },
                    items: [10, 20, 50, 100]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Page: $currentPage of $totalPages',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xFF727272),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    onPressed: currentPage > 1
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right),
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
        ),
      ),
    );
  }

  void _editItem(BuildContext context, Map<String, dynamic> fields) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fields.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    initialValue: entry.value.toString(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      fields[entry.key] = value;
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, ListItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                widget.items.remove(item);
                setState(() {
                  currentPage = 1;
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
