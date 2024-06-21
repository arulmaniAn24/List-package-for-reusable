import 'package:bloc/bloc.dart';
import 'package:dynamic_form/dynamic_form.dart';
import 'package:equatable/equatable.dart';
import 'package:proxima/src/data_collection/data_collection.dart';

part 'data_collection_event.dart';
part 'data_collection_state.dart';

class DataCollectionBloc
    extends Bloc<DataCollectionEvent, DataCollectionState> {
  DataCollectionBloc({
    required DataCollectionRepository dataCollectionRepository,
  })  : _dataCollectionRepository = dataCollectionRepository,
        super(const DataCollectionState()) {
    on<GetJsonFormData>(_onJsonDataRequested);
    
  }

  final DataCollectionRepository _dataCollectionRepository;

  Future<void> _onJsonDataRequested(
    GetJsonFormData event,
    Emitter<DataCollectionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => DataCollectionStatus.loading));
      final formData = await _dataCollectionRepository.getJsonData();
      emit(
        state.copyWith(
          status: () => DataCollectionStatus.success,
          formData: () => formData,
        ),
      );
    } catch (error) {
      state.copyWith(
        status: () => DataCollectionStatus.failure,
        message: error.toString,
      );
    }
  }
}
