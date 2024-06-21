import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitrite/nitrite.dart';
import 'package:proxima/l10n/l10.dart';
import 'package:proxima/src/app/routes.dart';
import 'package:proxima/src/data_collection/data_collection.dart';
import 'package:proxima/src/home/repo/home_data_repository.dart';
import 'package:proxima/src/login/login.dart';
import 'package:proxima/src/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({
    required this.localDB,
    super.key,
  });

  final Nitrite localDB;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(localDB: localDB),
        ),
        RepositoryProvider<DataCollectionRepository>(
          create: (context) => const DataCollectionRepository(),
        ),
        RepositoryProvider<HomeDataRepository>(
          create: (context) => const HomeDataRepository(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // To Generate L10n run this command : flutter gen-l10n
      supportedLocales: L10n.all,
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: Routes().router,
    );
  }
}
