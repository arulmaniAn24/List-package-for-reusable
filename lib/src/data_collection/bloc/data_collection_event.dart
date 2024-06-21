part of 'data_collection_bloc.dart';

sealed class DataCollectionEvent extends Equatable {
  const DataCollectionEvent();

  @override
  List<Object> get props => [];
}

final class GetJsonFormData extends DataCollectionEvent {
  const GetJsonFormData();
}
