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

      // Fetch local data from DB
      final homeDataLocal = await _homeDataRepository.fetchHomeDataFromDB();

      if (homeDataLocal == null) {
        final homePageData = await _homeDataRepository.getHomeData(true);
        emit(state.copyWith(
          status: () => HomeDataStatus.success,
          homeData: () => homePageData,
        ));
      } else {
        final homeDataFile = await _homeDataRepository.getHomeData(false);

        if (homeDataLocal.home?.version != homeDataFile.home?.version) {
          final homePageData = await _homeDataRepository.getHomeData(true);
          emit(state.copyWith(
            status: () => HomeDataStatus.success,
            homeData: () => homePageData,
          ));
        } else {
          emit(state.copyWith(
            status: () => HomeDataStatus.success,
            homeData: () => homeDataLocal,
          ));
        }
      }
    } catch (error) {
      emit(state.copyWith(
        status: () => HomeDataStatus.failure,
        message: () => error.toString(),
      ));
    }
  }

}
