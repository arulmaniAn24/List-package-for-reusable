part of 'user_preference_bloc.dart';

enum UserPreferenceStatus { initial, loading, success, failure }

final class UserPreferenceState extends Equatable {
  const UserPreferenceState(
      {this.status = UserPreferenceStatus.initial, this.userPreferenceData});

  final UserPreferenceStatus status;
  final UserPerference? userPreferenceData;

  UserPreferenceState copyWith({
    UserPreferenceStatus Function()? status,
    UserPerference? Function()? userPreferenceData,
  }) {
    return UserPreferenceState(
      status: status != null ? status() : this.status,
      userPreferenceData: userPreferenceData != null
          ? userPreferenceData()
          : this.userPreferenceData,
    );
  }

  @override
  List<Object> get props => [status];
}

final class UserPreferenceInitial extends UserPreferenceState {}
