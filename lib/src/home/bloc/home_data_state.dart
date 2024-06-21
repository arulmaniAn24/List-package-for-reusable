part of 'home_data_bloc.dart';

enum HomeDataStatus { initial, loading, success, failure }

final class HomeDataState extends Equatable {
  const HomeDataState({
    this.status = HomeDataStatus.initial,
    this.homeData,
    this.message,
  });

  final HomeDataStatus status;
  final HomePageData? homeData;
  final String? message;

  HomeDataState copyWith({
    HomeDataStatus Function()? status,
    HomePageData? Function()? homeData,
    String Function()? message,
  }) {
    return HomeDataState(
      status: status != null ? status() : this.status,
      homeData: homeData != null ? homeData() : this.homeData,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status];
}

final class HomeDataInitial extends HomeDataState {}
