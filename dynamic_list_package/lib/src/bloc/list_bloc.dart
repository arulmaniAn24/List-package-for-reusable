import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/list_item.dart';
import '../models/table_setting.dart';
import 'list_event.dart';
import 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  List<ListItem> originalItems = [];
  List<ListItem> currentItems = [];
  late TableSetting tableSetting;

  ListBloc() : super(ListInitial()) {
    on<FetchItems>(_mapFetchItemsToState);
    on<SearchItems>(_mapSearchItemsToState);
    on<FilterItems>(_mapFilterItemsToState);
    on<SortItems>(_mapSortItemsToState);
    on<UpdateColumns>(_mapUpdateColumnsToState);
    on<ToggleView>(_mapToggleViewToState);
    on<ClearFilter>(_mapClearFilterToState);
    on<ClearSort>(_mapClearSortToState);
  }

  Future<void> _mapFetchItemsToState(
      FetchItems event, Emitter<ListState> emit) async {
    print('Fetching items');
    emit(ListLoading());
    try {
      tableSetting = event.response.tableSetting;
      originalItems = event.response.data;

      print('Fetched items: ${originalItems.length} items');
      emit(ListLoaded(
        items: originalItems,
        columns: _getColumns(originalItems),
      ));
    } catch (e) {
      emit(ListError(message: 'Failed to fetch items: $e'));
    }
  }

  Future<void> _mapSearchItemsToState(
      SearchItems event, Emitter<ListState> emit) async {
    final currentState = state;
    if (currentState is ListLoaded) {
      if (event.query.isEmpty) {
        emit(ListLoaded(
            items: originalItems,
            columns: currentState.columns,
            isTableView: currentState.isTableView));
      } else {
        try {
          final List<ListItem> searchResults = originalItems.where((item) {
            return item.fields.values
                .any((value) => value.toString().contains(event.query));
          }).toList();
          emit(ListLoaded(
              items: searchResults,
              columns: currentState.columns,
              isTableView: currentState.isTableView));
        } catch (e) {
          emit(ListError(message: 'Failed to search items: $e'));
        }
      }
    }
  }

  void _mapFilterItemsToState(FilterItems event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      List<ListItem> filteredItems = originalItems;

      print(
          'Applying filter with column: ${event.column}, operator: ${event.operator}, value: ${event.value}');
      switch (event.operator) {
        case 'Equals':
          filteredItems = filteredItems
              .where((item) =>
                  item.fields[event.column].toLowerCase() ==
                  event.value.toLowerCase())
              .toList();
          break;
        case 'Contains':
          filteredItems = filteredItems
              .where((item) =>
                  item.fields[event.column]
                      ?.toLowerCase()
                      ?.contains(event.value.toLowerCase()) ??
                  false)
              .toList();
          break;
        case 'Starts with':
          filteredItems = filteredItems
              .where((item) =>
                  item.fields[event.column]
                      ?.toLowerCase()
                      ?.startsWith(event.value.toLowerCase()) ??
                  false)
              .toList();
          break;
        case 'Ends with':
          filteredItems = filteredItems
              .where((item) =>
                  item.fields[event.column]
                      ?.toLowerCase()
                      ?.endsWith(event.value.toLowerCase()) ??
                  false)
              .toList();
          break;
        default:
          break;
      }

      emit(ListLoaded(
          items: filteredItems,
          columns: currentState.columns,
          isTableView: currentState.isTableView));
    }
  }

  void _mapSortItemsToState(SortItems event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      final sortedItems = List<ListItem>.from(currentState.items);
      sortedItems.sort((a, b) {
        final aValue = a.fields[event.column]?.toString() ?? '';
        final bValue = b.fields[event.column]?.toString() ?? '';
        return event.isAscending
            ? aValue.compareTo(bValue)
            : bValue.compareTo(aValue);
      });
      emit(ListLoaded(
        items: sortedItems,
        columns: currentState.columns,
        isTableView: currentState.isTableView,
      ));
    }
  }

  void _mapUpdateColumnsToState(UpdateColumns event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      emit(ListLoaded(
          items: currentState.items,
          columns: event.columns,
          isTableView: currentState.isTableView));
    }
  }

  void _mapToggleViewToState(ToggleView event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      emit(ListLoaded(
          items: currentState.items,
          columns: currentState.columns,
          isTableView: !currentState.isTableView));
    }
  }

  List<String> _getColumns(List<ListItem> items) {
    if (items.isNotEmpty) {
      return items.first.fields.keys.toList();
    }
    return [];
  }

  void _mapClearFilterToState(ClearFilter event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      currentItems = originalItems;
      emit(ListLoaded(
          items: originalItems,
          columns: currentState.columns,
          isTableView: currentState.isTableView));
    }
  }

  void _mapClearSortToState(ClearSort event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      emit(ListLoaded(
        items: originalItems,
        columns: currentState.columns,
        isTableView: currentState.isTableView,
      ));
    }
  }
}
