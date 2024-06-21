import 'dart:convert';

import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// {@template data_collection_repository}
/// A repository that handles form data related requests.
/// {@endtemplate}
class DataCollectionRepository {
  /// {@macro data_collection_repository}
  const DataCollectionRepository();

  /// Provides a [JsonFormData] if the data is available.
  Future<JsonFormData> getJsonData() async {
    try {
      final response =
          await rootBundle.loadString('assets/data/form_data.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      final formData = JsonFormData.fromJson(data);
      return formData;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Get Json Form Exception $error');
      }
      throw JsonFormDataNotFoundException();
    }
  }
}

/// Error thrown when a [JsonFormData] with a given id is not found.
class JsonFormDataNotFoundException implements Exception {}
