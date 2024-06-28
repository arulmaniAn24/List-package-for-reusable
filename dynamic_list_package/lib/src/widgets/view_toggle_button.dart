import 'package:flutter/material.dart';

class ViewToggleButton extends StatelessWidget {
  final Function() onViewChanged;
  final bool isTableView;

  ViewToggleButton({required this.onViewChanged, required this.isTableView});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isTableView
          ? Icon(Icons.table_rows_sharp, color: Color(0xFF1F397A))
          : Icon(Icons.grid_view, color: Color(0xFF1F397A)),
      onPressed: onViewChanged,
    );
  }
}
