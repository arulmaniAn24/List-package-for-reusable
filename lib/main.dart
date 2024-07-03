import 'dart:convert';
import 'package:dynamic_list_package/dynamic_list_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_list_package/src/models/response_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic List Package',
      home: BlocProvider<ListBloc>(
        create: (context) => ListBloc(),
        child: Scaffold(
          //: AppBar(title: Text('Dynamic List')),
          body: FutureBuilder<ResponseModel>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return DynamicListWidget(response: snapshot.data!);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Future<ResponseModel> fetchData() async {
    final json = {
      "table_setting": {
        "sort": {"field_name": "name", "sort_by": "ASCE"},
        "columns_to_show": [],
        "default_view": "card"
      },
      "data": [
        {
          "createdAt": 1719241630,
          "name": "Name 1",
          "gender": "male",
          "mobile": "9876543210",
          "status": "Active",
          "email": "arul@gmail.com",
          "location": "location 1",
          "id": 1
        },
        {
          "createdAt": 1719241630,
          "name": "Name 2",
          "gender": "Male",
          "mobile": "9876543312",
          "status": "Away",
          "email": "mani@gmail.com",
          "location": "location 2",
          "id": 2
        },
        {
          "createdAt": 1719241630,
          "name": "Name 3",
          "gender": "Male",
          "mobile": "9876543312",
          "status": "Away",
          "email": "mani@gmail.com",
          "location": "location 3",
          "id": 2
        },
        {
          "createdAt": 1719241630,
          "name": "Name 4",
          "gender": "Male",
          "mobile": "9876543312",
          "status": "Inactive",
          "email": "mani@gmail.com",
          "location": "location 4",
          "id": 2
        },
        {
          "createdAt": 1719241630,
          "name": "Name 5",
          "gender": "Male",
          "mobile": "9876543312",
          "status": "Active",
          "email": "mani@gmail.com",
          "location": "location 5",
          "id": 2
        },
        {
          "createdAt": 1719241630,
          "name": "Name 6",
          "gender": "Male",
          "mobile": "9876543312",
          "status": "Active",
          "email": "mani@gmail.com",
          "location": "location 6",
          "id": 2
        }
      ]
    };

    return ResponseModel.fromJson(json);
  }
}
