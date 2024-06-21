import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitrite/nitrite.dart';
import 'package:proxima/src/app/app.dart';
import 'package:proxima/src/app/app_bloc_observer.dart';
import 'package:proxima/src/common/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = const AppBlocObserver();
  // Add cross-flavor configuration here
  final LocalDbRepository localDbRepository = LocalDbRepository();
  final Nitrite localDB = await localDbRepository.getLocalDbInstance();
  runApp(App(localDB: localDB));
}
