import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColumnSelectionWidget extends StatelessWidget {
  final List<String> allColumns;
  final Function(List<String>) onColumnsChanged;
  final List<String> initiallySelectedColumns;

  ColumnSelectionWidget({
    required this.allColumns,
    required this.onColumnsChanged,
    required this.initiallySelectedColumns,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showColumnSelectionMenu(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/images/customfilter.svg',
          width: 20,
          height: 20,
          color: const Color(0xFF1F397A),
        ),
      ),
    );
  }

  void _showColumnSelectionMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          enabled: false,
          child: _ColumnSelectionMenu(
            allColumns: allColumns,
            onColumnsChanged: onColumnsChanged,
            initiallySelectedColumns: initiallySelectedColumns,
          ),
        ),
      ],
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
        const Divider(),
        CheckboxListTile(
          title: const Text('Select All'),
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
          child: const Text('Save'),
        ),
      ],
    );
  }
}
