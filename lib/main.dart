import 'package:flutter/material.dart';
import 'package:task1/B%20signin%20signup/m.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(
        title: 'AppBar',
        icon: Icon(Icons.menu),
        icons: Icon(Icons.settings),
      
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  
  const HomePage(
      {super.key,
      required this.title,
      required this.icon, required this.icons,
      
      });
  final String title;
  final Widget icon;
  final Widget icons;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IconData> icons = [Icons.label];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(onPressed: () {}, icon: widget.icon),
        actions: [
          IconButton(onPressed: () {}, icon: widget.icons),
          IconButton(onPressed: () {}, icon: widget.icons),
        ],
      ),
    );
  }
}
