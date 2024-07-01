import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class About extends StatefulWidget {
  const About({super.key});
  static const String route = '/about';
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
        "About",
        style: TextStyle(fontSize: 20,color: Colors.white),
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${message?.notification?.title}'),
            Text('${message?.notification?.body}'),
            Text('Payload: ${message?.data.toString() ?? 'No Payload'}'),
          ],
        ),
      ),
    );
  }
}
