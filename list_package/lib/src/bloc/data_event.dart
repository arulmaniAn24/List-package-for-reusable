import '../widgets/data_list.dart';
import 'data_bloc.dart';
import 'package:equatable/equatable.dart';




abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends DataEvent {}

class ToggleViewEvent extends DataEvent {
  final DataViewType viewType;

  ToggleViewEvent(this.viewType);

  @override
  List<Object> get props => [viewType];
}

class SearchEvent extends DataEvent {
  final String query;

  SearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

class FilterEvent extends DataEvent {
  final Map<String, dynamic> filters;
  final String selectedFilter;

  FilterEvent({required this.filters, required this.selectedFilter});

  @override
  List<Object> get props => [filters, selectedFilter];
}

class SortEvent extends DataEvent {
  final String sortBy;
  final bool ascending;

  SortEvent({required this.sortBy, required this.ascending});

  @override
  List<Object> get props => [sortBy, ascending];
}
