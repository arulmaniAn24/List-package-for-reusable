import 'dart:async';

import 'package:first_app/Pages/login.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  void timer(){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()),);
    });

  }
  void seconds(){
    Timer(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()),);
    });
  }

  @override
  void initState() {
    // timer();
    seconds();
    super.initState();

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()),);
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 100.0,right: 100.0),
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.key_outlined,
                  color: Colors.white,
                  size: 80,
                ),
                Text(
                  "Access Key",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
