import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class SortIconWidget extends StatefulWidget {
  final List<String> columns;

  SortIconWidget({required this.columns});

  @override
  _SortIconWidgetState createState() => _SortIconWidgetState();
}

class _SortIconWidgetState extends State<SortIconWidget> {
  String? _sortedColumn;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSortPopup(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/images/sortby.svg',
          width: 20,
          height: 20,
          color: const Color(0xFF1F397A),
        ),
      ),
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
      items: [
        ...widget.columns.map((String column) {
          return PopupMenuItem<String>(
            value: column,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(column),
                  if (_sortedColumn == column)
                    Icon(
                      _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    ),
                ],
              ),
              onTap: () {
                _onColumnSelected(column);
              },
            ),
          );
        }).toList(),
        PopupMenuItem<String>(
          value: 'clear_sort',
          child: ListTile(
            leading: const Icon(Icons.clear),
            title: const Text('Clear Sort'),
            onTap: () {
              _onClearSortSelected();
            },
          ),
        ),
      ],
    );
  }

  void _onColumnSelected(String column) {
    setState(() {
      if (_sortedColumn == column) {
        _isAscending = !_isAscending;
      } else {
        _sortedColumn = column;
        _isAscending = true;
      }
    });
    context
        .read<ListBloc>()
        .add(SortItems(column: _sortedColumn!, isAscending: _isAscending));
    Navigator.pop(context);
  }

  void _onClearSortSelected() {
    setState(() {
      _sortedColumn = null;
      _isAscending = true;
    });
    context.read<ListBloc>().add(ClearSort());
    Navigator.pop(context);
  }
}
