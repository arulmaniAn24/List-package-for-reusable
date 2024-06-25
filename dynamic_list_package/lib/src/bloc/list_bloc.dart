import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/list_item.dart';
import '../services/api_service.dart';
import 'list_event.dart';
import 'list_state.dart';



class ListBloc extends Bloc<ListEvent, ListState> {
  final ApiService apiService;
  List<ListItem> originalItems = [];

  ListBloc({required this.apiService}) : super(ListInitial()) {
    on<FetchItems>(_mapFetchItemsToState);
    on<SearchItems>(_mapSearchItemsToState);
    on<FilterItems>(_mapFilterItemsToState);
    on<SortItems>(_mapSortItemsToState);
    on<UpdateColumns>(_mapUpdateColumnsToState);
    on<ToggleView>(_mapToggleViewToState);
  }

  Future<void> _mapFetchItemsToState(FetchItems event, Emitter<ListState> emit) async {
    emit(ListLoading());
    try {
      final List<ListItem> items = await ApiService.fetchUserData(event.userId);
      originalItems = items;
      emit(ListLoaded(items: items, columns: _getColumns(items)));
    } catch (e) {
      emit(ListError(message: 'Failed to fetch items: $e'));
    }
  }

  Future<void> _mapSearchItemsToState(SearchItems event, Emitter<ListState> emit) async {
    final currentState = state;
    if (currentState is ListLoaded) {
      if (event.query.isEmpty) {
        emit(ListLoaded(items: originalItems, columns: currentState.columns, isTableView: currentState.isTableView));
      } else {
        try {
          final List<ListItem> searchResults = await apiService.searchItems(event.query, originalItems);
          emit(ListLoaded(items: searchResults, columns: currentState.columns, isTableView: currentState.isTableView));
        } catch (e) {
          emit(ListError(message: 'Failed to search items: $e'));
        }
      }
    }
  }

void _mapFilterItemsToState(FilterItems event, Emitter<ListState> emit) {
  
    final currentState = state;
    if (currentState is ListLoaded) {
      List<ListItem> filteredItems;
      if (event.filter == 'Show All') {
        filteredItems = originalItems;
      } else if (event.filter == 'Filter by Name') {
        filteredItems = originalItems.where((item) => item.fields['name'] != null).toList();
      } else if (event.filter == 'Filter by male') {
        filteredItems = originalItems.where((item) => item.fields['gender'] == 'male').toList();
    
      } else {
        filteredItems = originalItems;
      }
      emit(ListLoaded(items: filteredItems, columns: currentState.columns, isTableView: currentState.isTableView));
    }
  

  }

  void _mapSortItemsToState(SortItems event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      final sortedItems = List<ListItem>.from(currentState.items);
      sortedItems.sort((a, b) => a.fields[event.sortBy].toString().compareTo(b.fields[event.sortBy].toString()));
      emit(ListLoaded(items: sortedItems, columns: currentState.columns, isTableView: currentState.isTableView));
    }
  }

  void _mapUpdateColumnsToState(UpdateColumns event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      emit(ListLoaded(items: currentState.items, columns: event.columns, isTableView: currentState.isTableView));
    }
  }

  void _mapToggleViewToState(ToggleView event, Emitter<ListState> emit) {
    final currentState = state;
    if (currentState is ListLoaded) {
      emit(ListLoaded(items: currentState.items, columns: currentState.columns, isTableView: !currentState.isTableView));
    }
  }

  List<String> _getColumns(List<ListItem> items) {
    if (items.isNotEmpty) {
      return items.first.fields.keys.toList();
    }
    return [];
  }
}
