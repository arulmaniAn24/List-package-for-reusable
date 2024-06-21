part of 'user_bloc.dart';

// class UserState{
//   List <dynamic> userData = [];
//   UserState(this.userData);
// }
// user_state.dart

class UserState {
  final List<dynamic> userData;

  UserState(this.userData);
}

class UserInitial extends UserState {
  UserInitial() : super([]);
}

class UserLoading extends UserState {
  UserLoading() : super([]);
}

class UserSuccess extends UserState {
  UserSuccess(List<dynamic> userData) : super(userData);
}

class UserFailure extends UserState {
  final String error;

  UserFailure(this.error) : super([]);
}
