part of 'home_data_bloc.dart';

sealed class HomeDataEvent extends Equatable {
  const HomeDataEvent();

  @override
  List<Object> get props => [];
}

final class GetJsonHomeData extends HomeDataEvent {
  const GetJsonHomeData();
}
