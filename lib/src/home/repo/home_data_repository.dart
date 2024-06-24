import 'dart:convert';
import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nitrite/nitrite.dart';

import '../utils/utils.dart';

class HomeDataRepository {
  const HomeDataRepository({required Nitrite localDB}) : _localDB = localDB;
  final Nitrite _localDB;

  static const String _collectionName = 'homeData';

// Fetch home data from file
  Future<HomePageData> getHomeData() async {
    try {
      final response =
          await rootBundle.loadString('assets/data/home_data.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      print("rootbundle data: $data");
      final homeData = HomePageData.fromJson(data);
      await saveHomeData(data);
      return homeData;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Get Json Home Exception $error');
      }
      throw HomeDataNotFoundException();
    }
  }

// Insert home data to database
  Future<void> saveHomeData(Map<String, dynamic> homeData) async {
    try {
      final NitriteCollection collection =
          await _localDB.getCollection(_collectionName);
      final Document document = documentFromMap(homeData);
      await collection.insert(document);
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Save HomeData Exception $error');
      }
      throw HomeDataSaveException();
    }
  }

// Fetch home data from database
  Future<HomePageData> fetchHomeDataFromDB() async {
    try {
      final NitriteCollection collection =
          await _localDB.getCollection(_collectionName);
      final Document? document = await collection.find().first;
      if (document == null) {
        throw HomeDataNotFoundException();
      }
      final Map<String, dynamic> data = convertDocumentToMap(document);
      final homeData = HomePageData.fromJson(data);
      return homeData;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Fetch HomeData Exception $error');
      }
      throw HomeDataNotFoundException();
    }
  }
}

class HomeDataNotFoundException implements Exception {}

class HomeDataSaveException implements Exception {}
