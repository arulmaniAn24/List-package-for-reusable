import 'package:bloc/bloc.dart';
import 'package:dynamic_home/dynamic_home.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:proxima/src/home/repo/home_data_repository.dart';

part 'home_data_event.dart';
part 'home_data_state.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, HomeDataState> {
  HomeDataBloc({required HomeDataRepository homeDataRepository})
      : _homeDataRepository = homeDataRepository,
        super(const HomeDataState()) {
    on<HomeDataEvent>(_onJsonDataRequested);
  }
  final HomeDataRepository _homeDataRepository;

  Future<void> _onJsonDataRequested(
    HomeDataEvent event,
    Emitter<HomeDataState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print('>> 1');
      }
      emit(state.copyWith(status: () => HomeDataStatus.loading));
      if (kDebugMode) {
        print('>> 2');
      }
      final homeData = await _homeDataRepository.getHomeData();
      if (kDebugMode) {
        print('>> 3');
      }
      emit(
        state.copyWith(
          status: () => HomeDataStatus.success,
          homeData: () => homeData,
        ),
      );
    } catch (error) {
      state.copyWith(
        status: () => HomeDataStatus.failure,
        message: error.toString,
      );
    }
  }
}
