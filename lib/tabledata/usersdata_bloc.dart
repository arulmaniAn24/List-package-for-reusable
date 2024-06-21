import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
part 'usersdata_event.dart';
part 'usersdata_state.dart';

class UsersDataBloc extends Bloc<UsersDataEvent, UserState> {
  UsersDataBloc() : super(UserState([])) {
    on<LoadUserData>((event, emit) async {
     String jsonString = await rootBundle.loadString('assets/users.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      List<dynamic> users = jsonData.map((json) => User.fromJson(json)).toList();
      emit(UserState(users));
    }
    );

    // on<ExportUserData>((event, emit) async {
    //   // Export operation
    // List<List<dynamic>> rows =[];
    // rows.add(["Id", "Name", "Username", "Email"]);
    //
    // users.forEach((user) {
    //   // print(user.id);
    //   rows.add([
    //     user.id,
    //     user.name,
    //     user.username,
    //     user.email,
    //   ]);
    // });
    // // print(rows);
    // String csv = const ListToCsvConverter().convert(rows);
    // // print(csv);
    // final bytes = utf8.encode(csv);
    // final blob = html.Blob([bytes]);
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.AnchorElement(href: url)
    //   ..setAttribute("download", "users_data.csv")
    //   ..click();
    // html.Url.revokeObjectUrl(url);
    // });
  }
}