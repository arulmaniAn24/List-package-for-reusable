import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minimalpage/screens/minimalsidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Minimal Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MinimalPage(),
      routes: [
        GoRoute(
          path: 'user',
          builder: (context, state) => const MinimalPage(),
          routes: [
            GoRoute(
              path: 'profile',
              builder: (context, state) => const MinimalPage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (context, state) => const MinimalPage(),
                ),
              ],
            ),
            GoRoute(
              path: 'cards',
              builder: (context, state) =>
                  const Center(child: Text('User Cards Content')),
            ),
          ],
        ),
      ],
    ),
  ],
);
