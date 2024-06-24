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

  @override
  void initState() {
    super.initState();
    selectedColumns = List.from(widget.initiallySelectedColumns);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.view_column),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Select Columns'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        ...widget.allColumns.map((column) {
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
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        widget.onColumnsChanged(selectedColumns);
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
