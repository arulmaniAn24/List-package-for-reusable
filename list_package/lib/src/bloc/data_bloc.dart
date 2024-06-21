import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/data_item.dart';
import '../repositories/data_repository.dart';
import 'data_event.dart';
import 'data_state.dart';




class DataBloc<T> extends Bloc<DataEvent, DataState<T>> {
  final DataRepository repository;
  final String listType;

  DataBloc(this.repository, this.listType) : super(DataInitial<T>()) {
    on<LoadDataEvent>(_onLoadData);
    on<ToggleViewEvent>(_onToggleView);
    on<SearchEvent>(_onSearch);
    on<FilterEvent>(_onFilter);
    on<SortEvent>(_onSort);
  }

  Future<void> _onLoadData(LoadDataEvent event, Emitter<DataState<T>> emit) async {
    emit(DataLoading<T>());
    try {
      List<DataItem<T>> dataList;
      if (listType == 'users') {
        dataList = await repository.fetchUserData() as List<DataItem<T>>;
      } else if (listType == 'employees') {
        dataList = await repository.fetchEmployeeData() as List<DataItem<T>>;
      } else {
        throw Exception('Unknown list type');
      }
      emit(DataLoaded<T>(
        originalData: dataList,
        filteredData: dataList,
        filterOptions: ['All', 'Admin', 'User'],
      ));
    } catch (e) {
      emit(DataError<T>('Failed to load data'));
    }
  }

  void _onToggleView(ToggleViewEvent event, Emitter<DataState<T>> emit) {
    if (state is DataLoaded<T>) {
      final currentState = state as DataLoaded<T>;
      emit(DataLoaded<T>(
        originalData: currentState.originalData,
        filteredData: currentState.filteredData,
        viewType: event.viewType,
        selectedFilter: currentState.selectedFilter,
        filterOptions: currentState.filterOptions,
      ));
    }
  }
  
void _onSearch(SearchEvent event, Emitter<DataState<T>> emit) {
  print("Search event received with query: ${event.query}");

  if (state is DataLoaded<T>) {
    final currentState = state as DataLoaded<T>;
    final query = event.query.toLowerCase();

    final List<DataItem<T>> filteredData = currentState.originalData.where((dataItem) {
      final data = dataItem.data as Map<String, dynamic>;

      final matches = data.values.any((value) => value.toString().toLowerCase().contains(query));
      print("Item: $data, Matches: $matches"); 

      return matches;
    }).toList();

    print("Filtered data length: ${filteredData.length}"); 

    emit(DataLoaded<T>(
      originalData: currentState.originalData,
      filteredData: filteredData,
      viewType: currentState.viewType,
      selectedFilter: currentState.selectedFilter,
      filterOptions: currentState.filterOptions,
    ));
  }
}


  void _onFilter(FilterEvent event, Emitter<DataState<T>> emit) {
    if (state is DataLoaded<T>) {
      final currentState = state as DataLoaded<T>;
      final filters = event.filters;
      final filteredData = currentState.originalData.where((dataItem) {
        final data = dataItem.data as Map<String, dynamic>;
        bool matchesFilter = true;
        filters.forEach((key, value) {
          if (data[key] != value) {
            matchesFilter = false;
          }
        });
        return matchesFilter;
      }).toList();
      emit(DataLoaded<T>(
        originalData: currentState.originalData,
        filteredData: filteredData,
        viewType: currentState.viewType,
        selectedFilter: event.selectedFilter,
        filterOptions: currentState.filterOptions,
      ));
    }
  }

  void _onSort(SortEvent event, Emitter<DataState<T>> emit) {
    if (state is DataLoaded<T>) {
      final currentState = state as DataLoaded<T>;
      final sortBy = event.sortBy;
      final ascending = event.ascending;
      List<DataItem<T>> sortedData = List.from(currentState.filteredData);
      sortedData.sort((a, b) {
        final aValue = (a.data as Map<String, dynamic>)[sortBy];
        final bValue = (b.data as Map<String, dynamic>)[sortBy];
        if (aValue is String && bValue is String) {
          return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
        } else if (aValue is num && bValue is num) {
          return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
        }
        return 0;
      });
      emit(DataLoaded<T>(
        originalData: currentState.originalData,
        filteredData: sortedData,
        viewType: currentState.viewType,
        selectedFilter: currentState.selectedFilter,
        filterOptions: currentState.filterOptions,
      ));
    }
  }
}
