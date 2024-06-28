import 'dart:convert';
import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nitrite/nitrite.dart';

import '../../utils/utils.dart';

class HomeDataRepository {
  const HomeDataRepository({required Nitrite localDB}) : _localDB = localDB;
  final Nitrite _localDB;

  static const String _collectionName = 'homeData';

// Fetch home data from file
  Future<HomePageData> getHomeData(bool version) async {
    try {
      // if (kDebugMode) {
      //   print('Attempting to load JSON data...');
      // }

      final response =
          await rootBundle.loadString('assets/data/home_data.json');

      // if (kDebugMode) {
      //   print('JSON data loaded successfully.');
      // }

      final data = jsonDecode(response) as Map<String, dynamic>;

      // if (kDebugMode) {
      //   print('Data fetched from file');
      // }

      final homeData = HomePageData.fromJson(data);

      // if (kDebugMode) {
      //   print('Data converted to HomePageData object.');
      // }
      if (version) {
        // if (kDebugMode) {
        //   print('New version Update to local database.');
        // }
        await saveHomeData(data);
        // if (kDebugMode) {
        //   print('New Data saved to local database.');
        // }
      }

      return homeData;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Get Json Home Exception: $error');
      }
      throw HomeDataNotFoundException();
    }
  }

// Insert home data to database
  Future<void> saveHomeData(Map<String, dynamic> homeData) async {
    try {
      if (kDebugMode) {
        print('Attempting to save data...');
      }

      final NitriteCollection collection =
          await _localDB.getCollection(_collectionName);

      await collection.clear();
      if (kDebugMode) {
        print('Collection Data Cleared');
      }

      final Document document = documentFromMap(homeData);

      if (kDebugMode) {
        print('Data to be stored in local');
      }

      await collection.insert(document);

      if (kDebugMode) {
        print('Data inserted successfully.');
      }
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Save HomeData Exception: $error');
      }
      throw HomeDataSaveException();
    }
  }

// Fetch home data from database
  Future<HomePageData?> fetchHomeDataFromDB() async {
    try {
      final NitriteCollection collection =
          await _localDB.getCollection(_collectionName);

      if (collection.size == 0) {
        if (kDebugMode) {
          print('No collection found in local database');
        }
        return null;
      }

      final Document? document = await collection.find().last;

      if (document == null) {
        if (kDebugMode) {
          print('No document found in local database');
        }
        return null;
      }

      if (kDebugMode) {
        print('Data fetched from local');
      }

      final Map<String, dynamic> data = convertDocumentToMap(document);
      final homeData = HomePageData.fromJson(data);
      return homeData;
    } catch (error) {
      if (kDebugMode) {
        print('>> Fetch HomeData Exception: $error');
      }
      return null; // In case of exception, return null
    }
  }
}

class HomeDataNotFoundException implements Exception {}

class HomeDataSaveException implements Exception {}
