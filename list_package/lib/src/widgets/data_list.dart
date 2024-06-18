// lib/widgets/data_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_bloc.dart';
import '../bloc/data_event.dart';
import '../bloc/data_state.dart';

import '../repositories/data_repository.dart';
import 'data_card_list.dart';
import 'data_table_list.dart';

enum DataViewType { card, table }

class DataList<T> extends StatelessWidget {
  final String listType;

  DataList({Key? key, required this.listType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DataBloc<T>(DataRepository(), listType)..add(LoadDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Data List'),
          actions: [
            BlocBuilder<DataBloc<T>, DataState<T>>(
              builder: (context, state) {
                if (state is DataLoaded<T>) {
                  return PopupMenuButton<DataViewType>(
                    onSelected: (viewType) {
                      context
                          .read<DataBloc<T>>()
                          .add(ToggleViewEvent(viewType));
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: DataViewType.card,
                        child: Text('Card View'),
                      ),
                      PopupMenuItem(
                        value: DataViewType.table,
                        child: Text('Table View'),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<DataBloc<T>, DataState<T>>(
          builder: (context, state) {
            if (state is DataLoading<T>) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DataLoaded<T>) {
              return state.viewType == DataViewType.card
                  ? DataCardList<T>(
                      data: state.data,
                      itemBuilder: (context, dataItem) {
                        final data = dataItem.data as Map<String, dynamic>;
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(data['name']),
                            subtitle: Text(data['email'] ?? data['position']),
                          ),
                        );
                      },
                    )
                  : DataTableList<T>(
                      data: state.data,
                      columns: [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Detail')),
                      ],
                      rowBuilder: (dataItem) {
                        final data = dataItem.data as Map<String, dynamic>;
                        return [
                          DataCell(Text(data['name'])),
                          DataCell(Text(data['email'] ?? data['position'])),
                        ];
                      },
                    );
            } else if (state is DataError<T>) {
              return Center(child: Text(state.error));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
