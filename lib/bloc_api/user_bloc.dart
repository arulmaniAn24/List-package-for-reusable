// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
//
// part 'user_event.dart';
// part 'user_state.dart';
//
// class UserBloc extends Bloc<UserEvent, UserState>{
//   final dio = Dio();
//  UserBloc () : super (UserState([])){
//    on<FetchUsers>(
//            (event, emit) async {
//                final response  = await dio.get('https://reqres.in/api/users');
//                // print(response.data);
//                final userData = response.data['data'];
//                emit(UserState(userData));
//            }
//            );
//  }
// }
// user_bloc.dart
// user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final dio = Dio();

  UserBloc() : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await dio.get('https://reqres.in/api/users');
        // print(response);
        if (response.statusCode == 200) {
          final userData = response.data['data'];
          emit(UserSuccess(userData));
        }
      } catch (e) {
        emit(UserFailure('Failed to fetch users: $e'));
      }
    });
  }
}
