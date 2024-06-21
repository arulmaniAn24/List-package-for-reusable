part of 'data_collection_bloc.dart';

enum DataCollectionStatus { initial, loading, success, failure }

final class DataCollectionState extends Equatable {
  const DataCollectionState({
    this.status = DataCollectionStatus.initial,
    this.formData,
    this.message,
  });

  final DataCollectionStatus status;
  final JsonFormData? formData;
  final String? message;

  DataCollectionState copyWith({
    DataCollectionStatus Function()? status,
    JsonFormData? Function()? formData,
    String Function()? message,
  }) {
    return DataCollectionState(
      status: status != null ? status() : this.status,
      formData: formData != null ? formData() : this.formData,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status];
}

final class DataCollectionInitial extends DataCollectionState {}
