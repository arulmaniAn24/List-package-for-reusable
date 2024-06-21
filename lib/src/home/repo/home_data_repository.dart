import 'dart:convert';

import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class HomeDataRepository {
  const HomeDataRepository();

  Future<HomePageData> getHomeData() async {
    try {
      final response =
          await rootBundle.loadString('assets/data/home_data.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      final homeData = HomePageData.fromJson(data);
      return homeData;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Get Json Home Exception $error');
      }
      throw HomeDataNotFoundException();
    }
  }
}

class HomeDataNotFoundException implements Exception {}
