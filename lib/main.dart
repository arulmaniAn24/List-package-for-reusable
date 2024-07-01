import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_notification/about.dart';
import 'package:push_notification/firebase_api.dart';
import 'package:push_notification/home.dart';
import 'package:push_notification/homepage.dart';
import 'package:push_notification/notification_page.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      home: const HomePage(),
      routes: {
        NotificationPage.route: (context) => const NotificationPage(),
        Home.route: (context) => const Home(),
        About.route: (context) => const About(),
      },
    );
  }
}


