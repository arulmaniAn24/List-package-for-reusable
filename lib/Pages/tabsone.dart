import 'package:flutter/material.dart';
class TabsOne extends StatefulWidget {
  const TabsOne({super.key});

  @override
  State<TabsOne> createState() => _TabsOneState();
}

class _TabsOneState extends State<TabsOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellowAccent,
        child: Center(
            child: Column(
              children: [
                Text("Methu",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Diya",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Teju",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Krish",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Adhi",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Karthik",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Mirthu",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text("Vishnu",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
