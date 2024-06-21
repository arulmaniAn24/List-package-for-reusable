import 'package:flutter/material.dart';
class TabsTwo extends StatefulWidget {
  const TabsTwo({super.key});

  @override
  State<TabsTwo> createState() => _TabsTwoState();
}

class _TabsTwoState extends State<TabsTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
            child: Text("Tab 2",
              style: TextStyle(
                fontSize: 30,
              ),
            )
        ),
      ),
    );
  }
}
