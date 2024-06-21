import 'package:flutter/material.dart';
class BottomSheetExample extends StatefulWidget {
  const BottomSheetExample({super.key});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  void showButton() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context)
        {
          return Container(
            padding: EdgeInsets.only(left: 50),
            height: 500,
            width: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orangeAccent,
            ),
            child: Row(
              children: [
                Text(
                  "Welcome to Bottom Sheet",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                    child: Text("Close")
                ),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton (
          onPressed: () {
            showButton();
          },
          child: Padding(
            padding: const EdgeInsets.only(left:30.0, right: 30.0,),
            child: Text("Open",
              style: TextStyle(fontSize: 30,color: Colors.white),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
