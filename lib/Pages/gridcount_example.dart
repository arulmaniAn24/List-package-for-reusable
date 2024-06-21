import 'package:flutter/material.dart';
class GridCountExample extends StatefulWidget {
  const GridCountExample({super.key});

  @override
  State<GridCountExample> createState() => _GridCountExampleState();
}

class _GridCountExampleState extends State<GridCountExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Text(
            "GridView Count",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount : 3,
          crossAxisSpacing: 4,
          children: List.generate(6, (index) {
            return Card(
              color: Colors.orangeAccent,
              child: Center(
                  child: Text("Search", style: TextStyle(
                    fontSize: 30,
                  ),)
              ),
            );
          }),
        ),
      ),
    );
  }
}
