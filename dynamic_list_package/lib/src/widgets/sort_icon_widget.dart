import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class SortIconWidget extends StatelessWidget {
  final List<String> columns;

  SortIconWidget({required this.columns});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.sort),
      onPressed: () {
        _showSortPopup(context);
      },
    );
  }

  void _showSortPopup(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final RelativeRect position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height,
      offset.dx + renderBox.size.width,
      offset.dy,
    );

    showMenu(
      context: context,
      position: position,
      items: columns.map((String column) {
        return PopupMenuItem<String>(
          value: column,
          child: ListTile(
            title: Text(column),
            onTap: () {
              Navigator.pop(context, column);
            },
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        context.read<ListBloc>().add(SortItems(value));
      }
    });
  }
}
