import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nitrite/nitrite.dart';
import 'package:nitrite_hive_adapter/nitrite_hive_adapter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:logger/logger.dart';

/// Thrown during the localDb operations, if a failure occurs.
class LocalDbFailure implements Exception {}

/// {@template LocalDb_repository}
/// Repository which manages local nitrite database operations.
/// {@endtemplate}
class LocalDbRepository {
  final log = Logger();
  late Nitrite localDb;

  /// {@macro LocalDb_repository}
  LocalDbRepository();

  Future<Nitrite> getLocalDbInstance() async {
    Nitrite? localDb;
    if (kIsWeb) {
      localDb = await Nitrite.builder()
          .fieldSeparator('.')
          .openOrCreate(username: 'sirius', password: 'S!rius11');
    } else {
      final Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();

      var dbDir = await Directory(
              '${appDocumentsDirectory.path}${Platform.pathSeparator}localdb')
          .create(recursive: true);

      /// ToDo Compression and Encryption to be added
      var storeModule =
          HiveModule.withConfig().crashRecovery(true).path(dbDir.path).build();
      localDb = await Nitrite.builder()
          .loadModule(storeModule)
          .fieldSeparator('.')
          .openOrCreate(username: 'sirius', password: 'S!rius11');
    }
    return localDb;
  }
}
