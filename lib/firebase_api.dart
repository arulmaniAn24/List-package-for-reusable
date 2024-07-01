import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/about.dart';
import 'package:push_notification/main.dart';
import 'package:push_notification/notification_page.dart';

import 'home.dart';

Future<void> handleMessage(RemoteMessage? message) async{
  //print(">> fmessage: ${message?.data}");
  if(message == null) return;

  // print("${message.data}");

  Future.delayed(Duration.zero,(){
    final page = message.data['page'];
    dynamic routeUrl;

    if(page == "about") {
      // print(" routeUrl");
      routeUrl = About.route;
    } else if (page == "home") {
      // print("routeUrl");
      routeUrl = Home.route;
    } else {
      routeUrl = NotificationPage.route;
    }
    // print("$routeUrl");
    navigatorKey.currentState?.pushNamed(
      routeUrl,
      arguments: message,
    );
  });
}


 class FirebaseApi{
   final _firebaseMessaging = FirebaseMessaging.instance;

    Future<void>initNotification() async{
      await _firebaseMessaging.requestPermission();
      final fcmToken = await _firebaseMessaging.getToken();
      print("Token: $fcmToken");

      // background
      FirebaseMessaging.onMessage.listen(handleMessage);

      // foreground
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

      // terminated- Check for initial message on app launch
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    }
 }