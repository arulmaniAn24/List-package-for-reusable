import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {

  const Home({super.key});
  static const String route = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "HomePage",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${message?.notification?.title}'),
            Text('${message?.notification?.body}'),
            Text('Payload: ${message?.data.toString() ?? 'No Payload'}'),
            // Text('message?.notification?.title ??'),
          ],
        ),
      ),
    );
  }
}
