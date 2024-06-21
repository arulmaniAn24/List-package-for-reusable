import 'dart:convert';

import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class HomeDataRepository {
  const HomeDataRepository();

  Future<HomePageData> getHomeData() async {
    try {
      if (kDebugMode) {
        print('>> 01');
      }
      final response =
          await rootBundle.loadString('assets/data/home_data.json');
      if (kDebugMode) {
        print('>> 02');
      }
      final data = jsonDecode(response) as Map<String, dynamic>;
      if (kDebugMode) {
        print('>> 03');
        print('>> $data');
      }
      final homeData = HomePageData.fromJson(data);
      if (kDebugMode) {
        print('>> Get Json Home Data $homeData');
      }
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
