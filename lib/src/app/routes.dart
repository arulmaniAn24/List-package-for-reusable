import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proxima/src/app/route_names.dart';
import 'package:proxima/src/data_collection/data_collection.dart';
import 'package:proxima/src/home/home.dart';

class Routes {
  /// The route configuration.
  GoRouter router = GoRouter(
    initialLocation: '/dynamic-home',
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.login,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: Center(
              child: Text('Login'),
            ),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            name: RouteNames.dynamicForm,
            path: 'dynamic-form',
            builder: (BuildContext context, GoRouterState state) {
              return const Scaffold(
                body: Center(
                  child: DynamicFormPage(),
                ),
              );
            },
          ),
          GoRoute(
            name: RouteNames.dynamicHome,
            path: 'dynamic-home',
            builder: (BuildContext context, GoRouterState state) {
              return const Scaffold(
                body: Center(
                  child: DynamicHomePage(),
                ),
              );
            },
          ),
        ],
        redirect: (BuildContext context, GoRouterState state) {
          // final bool signedIn =
          //     context.select((LoginBloc loginBloc) => loginBloc.state.status) ==
          //         LoginStatus.loggedIn;
          // //final bool signedIn = _loginBloc.state.status == LoginStatus.loggedIn;
          // final bool signingIn = state.matchedLocation == '/login';

          // if (!signedIn && !signingIn) {
          //   return '/login';
          // } else if (signedIn && signingIn) {
          //   return '/';
          // }

          // no redirect
          return null;
        },
      ),
    ],
    debugLogDiagnostics: false,
    // changes on the listenable will cause the router to refresh it's route
    // refreshListenable: GoRouterRefreshStream(_loginBloc.stream),
  );
}
