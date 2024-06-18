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

  const ToggleViewEvent(this.viewType);

  @override
  List<Object> get props => [viewType];
}
