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
  }

  Future<void> _onLoadData(
      LoadDataEvent event, Emitter<DataState<T>> emit) async {
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
      emit(DataLoaded<T>(dataList));
    } catch (e) {
      emit(DataError<T>('Failed to load data'));
    }
  }

  void _onToggleView(ToggleViewEvent event, Emitter<DataState<T>> emit) {
    if (state is DataLoaded<T>) {
      final currentState = state as DataLoaded<T>;
      emit(DataLoaded<T>(currentState.data, viewType: event.viewType));
    }
  }
}
