import 'package:flutter/material.dart';

class ColumnSelectionWidget extends StatefulWidget {
  final List<String> allColumns;
  final Function(List<String>) onColumnsChanged;
  final List<String> initiallySelectedColumns;

  ColumnSelectionWidget({
    required this.allColumns,
    required this.onColumnsChanged,
    required this.initiallySelectedColumns,
  });

  @override
  _ColumnSelectionWidgetState createState() => _ColumnSelectionWidgetState();
}

class _ColumnSelectionWidgetState extends State<ColumnSelectionWidget> {
  late List<String> selectedColumns;
  bool selectAll = false;
  TextEditingController searchController = TextEditingController();
  List<String> filteredColumns = [];

  @override
  void initState() {
    super.initState();
    selectedColumns = List.from(widget.initiallySelectedColumns);
    filteredColumns = List.from(widget.allColumns);
    searchController.addListener(filterColumns);
  }

  void filterColumns() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredColumns = List.from(widget.allColumns);
      } else {
        filteredColumns = widget.allColumns
            .where((column) => column.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.view_column,
        color: Color(0xFF1F397A),
      ),
      onPressed: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(100, 100, 0, 0),
          items: [
            PopupMenuItem(
              enabled: false,
              child: _ColumnSelectionMenu(
                allColumns: widget.allColumns,
                initiallySelectedColumns: widget.initiallySelectedColumns,
                onColumnsChanged: widget.onColumnsChanged,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ColumnSelectionMenu extends StatefulWidget {
  final List<String> allColumns;
  final Function(List<String>) onColumnsChanged;
  final List<String> initiallySelectedColumns;

  _ColumnSelectionMenu({
    required this.allColumns,
    required this.onColumnsChanged,
    required this.initiallySelectedColumns,
  });

  @override
  __ColumnSelectionMenuState createState() => __ColumnSelectionMenuState();
}

class __ColumnSelectionMenuState extends State<_ColumnSelectionMenu> {
  late List<String> selectedColumns;
  bool selectAll = false;
  TextEditingController searchController = TextEditingController();
  List<String> filteredColumns = [];

  @override
  void initState() {
    super.initState();
    selectedColumns = List.from(widget.initiallySelectedColumns);
    filteredColumns = List.from(widget.allColumns);
    searchController.addListener(filterColumns);
  }

  void filterColumns() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredColumns = List.from(widget.allColumns);
      } else {
        filteredColumns = widget.allColumns
            .where((column) => column.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search columns...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        Divider(),
        CheckboxListTile(
          title: Text('Select All'),
          value: selectAll,
          onChanged: (bool? isChecked) {
            setState(() {
              selectAll = isChecked!;
              if (isChecked) {
                selectedColumns = List.from(widget.allColumns);
              } else {
                selectedColumns.clear();
              }
            });
          },
        ),
        Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: filteredColumns.map((column) {
                return CheckboxListTile(
                  title: Text(column),
                  value: selectedColumns.contains(column),
                  onChanged: (bool? isChecked) {
                    setState(() {
                      if (isChecked != null) {
                        if (isChecked) {
                          selectedColumns.add(column);
                        } else {
                          selectedColumns.remove(column);
                          selectAll = false;
                        }
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onColumnsChanged(selectedColumns);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
