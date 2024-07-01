import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  static const route = '/notification_page';
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    //final notificationTitle = message.notification?.title;
    return Scaffold(
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

