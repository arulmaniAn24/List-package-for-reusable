import 'package:equatable/equatable.dart';
import '../models/list_item.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final List<ListItem> items;
  final List<String> columns;
  final bool isTableView;

  const ListLoaded({required this.items, required this.columns, this.isTableView = false});

  @override
  List<Object> get props => [items, columns, isTableView];
}

class ListError extends ListState {
  final String message;

  const ListError({required this.message});

  @override
  List<Object> get props => [message];
}
