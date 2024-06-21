import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task1/B%20signin%20signup/Forgot.dart';
import 'package:task1/B%20signin%20signup/SignUp.dart';
import 'package:task1/B%20signin%20signup/Otp.dart';
import 'package:task1/B%20signin%20signup/SignIn.dart';
import 'package:task1/B%20signin%20signup/Stored.dart';
import 'package:task1/B%20signin%20signup/Stored_Data.dart';
// import 'package:untitled/Forgot.dart';
// import 'package:untitled/Otp.dart';
// import 'package:untitled/Page1.dart';
// import 'package:untitled/Habit%20Diary.dart';
// import 'package:untitled/Page2.dart';
// import 'package:untitled/Page3.dart';
// import 'package:untitled/RouteName.dart';
// import 'package:untitled/bottom%20navigationbar.dart';
// import 'package:untitled/SignIn.dart';
// import 'package:untitled/SignUpp.dart';

// import 'package:untitled/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router',
      routerConfig: _router,
    );
  }

  final GoRouter  _router = GoRouter(routes: [
    GoRoute(path: "/", builder: (context, state) => const SignIn()),
    GoRoute(path: "/SignUp", builder: (context, state) =>const SignUp()),
    GoRoute(path: "/Forgot", builder: (context, state) =>const Forgot()),
    GoRoute(path: "/Otp", builder: (context, state) =>const Otp()),
    GoRoute(path: "/Stored_Data", builder: (context, state) => Stored_Data()),
    GoRoute(path: "/Stored", builder: (context, state) => Stored()),
  ]);
  
}

