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
          appBar: AppBar(title: Text('Dynamic List')),
          body: FutureBuilder<ResponseModel>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
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
          "name": "name 5",
          "avatar": "avatar 5",
          "gender": "female",
          "mobile": "mobile 5",
          "status": "status 5",
          "email": "email 5",
          "location": "location 5",
          "id": 5
        },
        {
          "createdAt": 1719241630,
          "name": "name 7",
          "avatar": "avatar 5",
          "gender": "female",
          "mobile": "mobile 5",
          "status": "status 5",
          "email": "email 5",
          "location": "location 5",
          "id": 5
        }
      ]
    };

    return ResponseModel.fromJson(json);
  }
}
