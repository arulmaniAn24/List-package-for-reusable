import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nitrite/nitrite.dart';
import 'package:proxima/models/user_perference.dart';
import 'package:proxima/src/utils/utils.dart';

class UserPreferenceRepository {
  const UserPreferenceRepository({required Nitrite localDB})
      : _localDB = localDB;
  final Nitrite _localDB;
  static const String _collectionName = 'userPreferencData';

  // Fetch home data from file
  Future<UserPerference> getUserPreferenceData() async {
    try {
      if (kDebugMode) {
        print('Attempting to load JSON data...');
      }

      final response =
          await rootBundle.loadString('assets/data/user_preference.json');

      if (kDebugMode) {
        print('JSON data loaded successfully.');
      }

      final data = jsonDecode(response) as Map<String, dynamic>;

      if (kDebugMode) {
        print('Data fetched from file');
      }

      final userPerferenceData = UserPerference.fromJson(data);

      if (kDebugMode) {
        print('Data converted to UserPerference object.');
      }
      if (kDebugMode) {
        print('New version Update to local database.');
      }
      await saveUserPreferenceData(data);
      if (kDebugMode) {
        print('New Data saved to local database.');
      }

      return userPerferenceData;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Get Json Home Exception: $error');
      }
      throw UserPreferenceDataNotFoundException();
    }
  }

  // Insert home data to database
  Future<void> saveUserPreferenceData(
      Map<String, dynamic> userPreferenceData) async {
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

      final Document document = documentFromMap(userPreferenceData);

      if (kDebugMode) {
        print('Data to be stored in local');
      }

      await collection.insert(document);

      if (kDebugMode) {
        print('Data inserted successfully.');
      }
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Save UserPreferenceData Exception: $error');
      }
      throw UserPreferenceDataSaveException();
    }
  }

  // Fetch home data from database
  Future<UserPerference?> fetchUserPreferenceFromDB() async {
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
      final userPreferenceData = UserPerference.fromJson(data);
      return userPreferenceData;
    } catch (error) {
      if (kDebugMode) {
        print('>> Fetch UserPreferenceData Exception: $error');
      }
      return null;
    }
  }
}

class UserPreferenceDataNotFoundException implements Exception {}

class UserPreferenceDataSaveException implements Exception {}
