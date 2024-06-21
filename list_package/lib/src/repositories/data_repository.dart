

import 'dart:convert';
import '../models/data_item.dart';

class DataRepository {
  Future<List<DataItem>> fetchUserData() async {
  
    return [
      DataItem(data: {'name': 'Alice', 'email': 'alice@example.com'}),
      DataItem(data: {'name': 'John', 'email': 'john@example.com'}),
      DataItem(data: {'name': 'Charlie', 'email': 'charlie@example.com'}),
    ];
  }

  Future<List<DataItem>> fetchEmployeeData() async {

    return [
      DataItem(data: {'name': 'Alice', 'position': 'Manager'}),
      DataItem(data: {'name': 'John', 'position': 'Developer'}),
      DataItem(data: {'name': 'Charlie', 'position': 'Designer'}),
    ];
  }
}
