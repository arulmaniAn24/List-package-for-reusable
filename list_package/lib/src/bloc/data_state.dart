import '../models/data_item.dart';
import '../widgets/data_list.dart';
import 'data_bloc.dart';

import 'package:equatable/equatable.dart';


abstract class DataState<T> extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial<T> extends DataState<T> {}

class DataLoading<T> extends DataState<T> {}

class DataLoaded<T> extends DataState<T> {
  final List<DataItem<T>> originalData;
  final List<DataItem<T>> filteredData;
  final DataViewType viewType;
  final String? selectedFilter;
  final List<String> filterOptions;

  const DataLoaded({
    required this.originalData,
    required this.filteredData,
    this.viewType = DataViewType.card,
    this.selectedFilter,
    required this.filterOptions,
  });

  @override
  List<Object> get props => [
        originalData,
        filteredData,
        viewType,
        selectedFilter ?? '',
        filterOptions,
      ];
}

class DataError<T> extends DataState<T> {
  final String error;

  const DataError(this.error);

  @override
  List<Object> get props => [error];
}


class SearchState<T> extends DataState<T> {
  final String query;

  SearchState(this.query);

  @override
  List<Object> get props => [query];
}
