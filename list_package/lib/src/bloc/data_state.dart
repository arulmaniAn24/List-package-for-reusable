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
  final List<DataItem<T>> data;
  final DataViewType viewType;

  const DataLoaded(this.data, {this.viewType = DataViewType.card});

  @override
  List<Object> get props => [data, viewType];
}

class DataError<T> extends DataState<T> {
  final String error;

  const DataError(this.error);

  @override
  List<Object> get props => [error];
}
