import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proxima/src/common/widgets/skeleton_loader.dart';
import 'package:proxima/src/home/bloc/home_data_bloc.dart';
import 'package:proxima/src/home/repo/home_data_repository.dart';

class DynamicHomePage extends StatelessWidget {
  const DynamicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeDataBloc(homeDataRepository: context.read<HomeDataRepository>())
            ..add(const GetJsonHomeData()),
      child: const DynamicHomeView(),
    );
  }
}

class DynamicHomeView extends StatefulWidget {
  const DynamicHomeView({super.key});

  @override
  State<DynamicHomeView> createState() => _DynamicHomeViewState();
}

class _DynamicHomeViewState extends State<DynamicHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeDataBloc, HomeDataState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == HomeDataStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.message})',
                  ),
                ),
              );
          }
        },
        child: BlocBuilder<HomeDataBloc, HomeDataState>(
          builder: (context, state) {
            if (kDebugMode) {
              print('>> home scree data ${state.status} ||  ${state.homeData}');
            }
            if (state.homeData != null) {
              final homeData = state.homeData;
              if (state.status == HomeDataStatus.loading) {
                return const Center(child: SkeletonLoader());
              } else if (state.status == HomeDataStatus.success) {
                Locale locale = Localizations.localeOf(context);
                return Center(
                    child: DynamicHomeWidget(
                  homePageData: homeData!,
                  leadingTitle: 'Hi, Ben',
                  currentLanguage: locale.languageCode,
                ));
              }
              return Center(
                child: Text(
                  'Try Again',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            } else {
              return const Center(child: SkeletonLoader());
            }
          },
        ),
      ),
    );
  }
}
