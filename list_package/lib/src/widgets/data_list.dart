

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
        create: (context) => DataBloc<T>(DataRepository(), listType)..add(LoadDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Data List'),
          actions: [
            BlocBuilder<DataBloc<T>, DataState<T>>(
              builder: (context, state) {
                if (state is DataLoaded<T>) {
                  return PopupMenuButton<DataViewType>(
                    onSelected: (viewType) {
                      context.read<DataBloc<T>>().add(ToggleViewEvent(viewType));
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
        body: Column(
          children: [
            _buildSearchBar(context),
            _buildFilterDropdown(context),
            _buildSortButton(context),
           Expanded(
  child: BlocListener<DataBloc<T>, DataState<T>>(
    listener: (context, state) {
      if (state is DataLoaded<T>) {
        print("Filtered data count in BlocListener: ${state.filteredData.length}");
      }
    },
    child: BlocBuilder<DataBloc<T>, DataState<T>>(
      builder: (context, state) {
        if (state is DataLoaded<T>) {
          print("Rebuilding UI with ${state.filteredData.length} items"); 
          return state.viewType == DataViewType.card
              ? DataCardList<T>(
                  data: state.filteredData,
                  itemBuilder: (context, dataItem) {
                    final data = dataItem.data as Map<String, dynamic>;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(data['name'] ?? ''),
                        subtitle: Text(data['email'] ?? data['position'] ?? ''),
                      ),
                    );
                  },
                )
              : DataTableList<T>(
                  data: state.filteredData,
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Detail')),
                  ],
                  rowBuilder: (dataItem) {
                    final data = dataItem.data as Map<String, dynamic>;
                    return [
                      DataCell(Text(data['name'] ?? '')),
                      DataCell(Text(data['email'] ?? data['position'] ?? '')),
                    ];
                  },
                );
        } else if (state is DataError<T>) {
          return Center(child: Text(state.error));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
  ),
),

          ],
        ),
      ),
    );
  }
   Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), 
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          print("Search query changed: $value"); 
          context.read<DataBloc<T>>().add(SearchEvent(value));
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              context.read<DataBloc<T>>().add(SearchEvent(''));
            },
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    ),
  );
}




  Widget _buildFilterDropdown(BuildContext context) {
    return BlocBuilder<DataBloc<T>, DataState<T>>(
      builder: (context, state) {
        if (state is DataLoaded<T>) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: state.selectedFilter ?? 'All',
              onChanged: (newValue) {
                context.read<DataBloc<T>>().add(FilterEvent(filters: {'type': newValue}, selectedFilter: newValue!));
              },
              items: state.filterOptions.map((filter) {
                return DropdownMenuItem<String>(
                  value: filter,
                  child: Text(filter),
                );
              }).toList(),
              hint: const Text('Filter'),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildSortButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
      
          context.read<DataBloc<T>>().add(SortEvent(sortBy: 'name', ascending: true));
        },
        child: const Text('Sort by Name'),
      ),
    );
  }
}
