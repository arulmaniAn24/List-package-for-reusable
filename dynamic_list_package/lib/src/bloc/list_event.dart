import 'package:equatable/equatable.dart';



abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class FetchItems extends ListEvent {
  final int userId;

  const FetchItems(this.userId);

  @override
  List<Object> get props => [userId];
}

class SearchItems extends ListEvent {
  final String query;

  const SearchItems({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterItems extends ListEvent {
  final String filter;

  const FilterItems(this.filter);

  @override
  List<Object> get props => [filter];
}

class SortItems extends ListEvent {
  final String sortBy;

  const SortItems(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}

class UpdateColumns extends ListEvent {
  final List<String> columns;

  const UpdateColumns(this.columns);

  @override
  List<Object> get props => [columns];
}

class ToggleView extends ListEvent {}
