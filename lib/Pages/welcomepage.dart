import 'package:flutter/material.dart';
class WelcomePage extends StatefulWidget {
  final String name;
      final String mobileno;
  WelcomePage({required this.name, required this.mobileno});


  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // String name,mobileno;
  // _WelcomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Welcome Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Name: ${widget.name}",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "Mobile: ${widget.mobileno}",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
