import 'dart:async';

import '../models/list_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      'https://664c430f35bbda10987f7eb5.mockapi.io/login/sendotp/user';

  static Future<List<ListItem>> fetchUserData(int userId) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ListItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user list');
    }
  }

  Future<List<ListItem>> searchItems(
      String query, List<ListItem> localItems) async {
    final url = '$baseUrl?q=$query';
    print('Searching items with URL: $url');
    final response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ListItem.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      final List<ListItem> filteredItems =
          localItems.where((item) => item.matchesQuery(query)).toList();
      print('Local search results: $filteredItems');
      return filteredItems;
    } else {
      throw Exception('Failed to search items');
    }
  }
}
