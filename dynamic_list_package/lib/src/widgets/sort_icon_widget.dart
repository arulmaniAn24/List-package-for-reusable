// sort_icon_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class SortIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.sort),
      onSelected: (String sortBy) {
        context.read<ListBloc>().add(SortItems(sortBy));
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'name',
          child: ListTile(
            title: Text('Name'),
            onTap: () {
              Navigator.pop(context, 'name');
            },
          ),
        ),

        // PopupMenuItem<String>(
        //   value: 'date',
        //   child: ListTile(
        //     title: Text('Date'),
        //     onTap: () {
        //       Navigator.pop(context, 'date');
        //     },
        //   ),
        // ),
      ],
    );
  }
}
