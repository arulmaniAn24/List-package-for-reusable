import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class FilterIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.filter_list),
      onSelected: (String value) {
        context.read<ListBloc>().add(FilterItems(value));
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Show All',
            child: Text('Show All'),
          ),
          PopupMenuItem<String>(
            value: 'Filter by Name',
            child: Text('Filter by Name'),
          ),
          PopupMenuItem<String>(
            value: 'Filter by male',
            child: Text('Filter by male'),
          ),
         
        ];
      },
    );
  }
}
