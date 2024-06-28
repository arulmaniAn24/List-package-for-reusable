import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class FilterIconWidget extends StatelessWidget {
  final List<String> columns;

  FilterIconWidget({required this.columns});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.filter_alt,
        color: Color(0xFF1F397A),
      ),
      onPressed: () {
        _showFilterPopup(context);
      },
    );
  }

  void _showFilterPopup(BuildContext context) {
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
        PopupMenuItem(
          enabled: false,
          child: BlocProvider.value(
            value: BlocProvider.of<ListBloc>(context),
            child: FilterPopupContent(columns: columns),
          ),
        ),
        PopupMenuItem(
          value: 'Clear Filter',
          child: ListTile(
            leading: Icon(Icons.clear),
            title: Text('Clear Filter'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'Clear Filter') {
        context.read<ListBloc>().add(ClearFilter());
      }
    });
  }
}

class FilterPopupContent extends StatefulWidget {
  final List<String> columns;

  FilterPopupContent({required this.columns});

  @override
  _FilterPopupContentState createState() => _FilterPopupContentState();
}

class _FilterPopupContentState extends State<FilterPopupContent> {
  String? selectedColumn;
  String? selectedOperator;
  final TextEditingController _valueController = TextEditingController();

  final List<String> operators = [
    'Equals',
    'Contains',
    'Starts with',
    'Ends with'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: selectedColumn,
            hint: Text('Select Column'),
            isExpanded: true,
            items: widget.columns.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedColumn = newValue;
              });
            },
          ),
          SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedOperator,
            hint: Text('Select Operator'),
            isExpanded: true,
            items: operators.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedOperator = newValue;
              });
            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(
              labelText: 'Value',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (selectedColumn != null && selectedOperator != null) {
                    context.read<ListBloc>().add(FilterItems(
                          column: selectedColumn!,
                          operator: selectedOperator!,
                          value: _valueController.text,
                        ));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Filter'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
