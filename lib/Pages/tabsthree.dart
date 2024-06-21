import 'package:flutter/material.dart';
class TabsThree extends StatefulWidget {
  const TabsThree({super.key});

  @override
  State<TabsThree> createState() => _TabsThreeState();
}

class _TabsThreeState extends State<TabsThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreen,
        child: Center(
            child: Text("Tab 3",
              style: TextStyle(
                fontSize: 30,
              ),
            )
        ),
      ),
    );
  }
}
