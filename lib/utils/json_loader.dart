import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:minimalpage/models/menu.dart';

Future<List<MenuItem>> loadMenuItems() async {
  try {
    final String response =
        await rootBundle.loadString('assets/menu_items.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;
    return data
        .map((json) => MenuItem.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Error loading menu items: $e');
    return [];
  }
}
