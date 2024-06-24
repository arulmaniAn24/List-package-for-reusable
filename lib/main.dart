import 'dart:convert';
import 'package:dynamic_list_package/dynamic_list_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dynamic_list_package/src/services/api_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = await loadConfig();

  runApp(MyApp(config: config));
}

Future<Map<String, dynamic>> loadConfig() async {
  String jsonString = await rootBundle.loadString('assets/config.json');
  return jsonDecode(jsonString);
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> config;

  MyApp({required this.config});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListBloc(apiService: ApiService()), // Correct instantiation
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Dynamic List')),
          body: DynamicListWidget(
            userId: config['userId'],
            filterCriteria: config['filterCriteria'],
            sortBy: config['sortBy'],
        
            defaultView: config['defaultView'],
          ),
        ),
      ),
    );
  }
}
