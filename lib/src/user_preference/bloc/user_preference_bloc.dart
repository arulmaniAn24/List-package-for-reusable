import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proxima/models/user_perference.dart';
import 'package:proxima/src/user_preference/repo/user_preference_repository.dart';

part 'user_preference_event.dart';
part 'user_preference_state.dart';

class UserPreferenceBloc
    extends Bloc<UserPreferenceEvent, UserPreferenceState> {
  UserPreferenceBloc(
      {required UserPreferenceRepository userPreferenceDataRepository})
      : _userPreferenceDataRepository = userPreferenceDataRepository,
        super(UserPreferenceInitial()) {
    on<UserPreferenceEvent>(_onJsonUserPreferenceDataRequested);
  }
  final UserPreferenceRepository _userPreferenceDataRepository;
  Future<void> _onJsonUserPreferenceDataRequested(
    UserPreferenceEvent event,
    Emitter<UserPreferenceState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => UserPreferenceStatus.loading));
      await _userPreferenceDataRepository.getUserPreferenceData();
      final userPreferenceData =
          await _userPreferenceDataRepository.fetchUserPreferenceFromDB();
      emit(state.copyWith(
        status: () => UserPreferenceStatus.success,
        userPreferenceData: () => userPreferenceData,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: () => UserPreferenceStatus.failure,
      ));
    }
  }
}
