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
  final String column;
  final String operator;
  final String value;

  const FilterItems({
    required this.column,
    required this.operator,
    required this.value,
  });

  @override
  List<Object> get props => [column, operator, value];
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

class ClearFilter extends ListEvent {}
