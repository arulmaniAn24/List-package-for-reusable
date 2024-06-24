import 'package:bloc/bloc.dart';
import 'package:dynamic_home/dynamic_home.dart';
import 'package:equatable/equatable.dart';
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
      emit(state.copyWith(status: () => HomeDataStatus.loading));
      await _homeDataRepository.getHomeData();
      final homeData = await _homeDataRepository.fetchHomeDataFromDB();
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
