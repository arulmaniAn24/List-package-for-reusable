import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitrite/nitrite.dart';
import 'package:proxima/l10n/l10.dart';
import 'package:proxima/models/user_perference.dart';
import 'package:proxima/src/app/routes.dart';
import 'package:proxima/src/common/widgets/skeleton_loader.dart';
import 'package:proxima/src/data_collection/data_collection.dart';
import 'package:proxima/src/home/repo/home_data_repository.dart';
import 'package:proxima/src/login/login.dart';
import 'package:proxima/src/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proxima/src/user_preference/bloc/user_preference_bloc.dart';
import 'package:proxima/src/user_preference/repo/user_preference_repository.dart';

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
        RepositoryProvider<UserPreferenceRepository>(
          create: (context) => UserPreferenceRepository(localDB: localDB),
        ),
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(localDB: localDB),
        ),
        RepositoryProvider<DataCollectionRepository>(
          create: (context) => const DataCollectionRepository(),
        ),
        RepositoryProvider<HomeDataRepository>(
          create: (context) => HomeDataRepository(localDB: localDB),
        ),
      ],
      child: BlocProvider(
        create: (context) => UserPreferenceBloc(
          userPreferenceDataRepository:
              context.read<UserPreferenceRepository>(),
        )..add(const GetJsonUserPreferenceData()),
        child: BlocListener<UserPreferenceBloc, UserPreferenceState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == UserPreferenceStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.status}'),
                  ),
                );
            }
          },
          child: BlocBuilder<UserPreferenceBloc, UserPreferenceState>(
            builder: (context, state) {
              if (kDebugMode) {
                print(
                    '>> User preference data ${state.status} || ${state.userPreferenceData?.userPreferences.language}');
              }
              if (state.status == UserPreferenceStatus.loading) {
                return const MaterialApp(home: Center(child: SkeletonLoader()));
              } else if (state.status == UserPreferenceStatus.success &&
                  state.userPreferenceData != null) {
                return AppView(userPreferenceData: state.userPreferenceData!);
              } else {
                return MaterialApp(
                  home: Scaffold(
                    body: Center(
                      child: Text(
                        'Try Again',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.userPreferenceData});

  final UserPerference userPreferenceData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      supportedLocales: L10n.all,
      locale: Locale(userPreferenceData.userPreferences.language),
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
