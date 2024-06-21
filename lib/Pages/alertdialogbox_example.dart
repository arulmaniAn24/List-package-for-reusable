import 'package:flutter/material.dart';
class AlertDialogboxExample extends StatefulWidget {
  const AlertDialogboxExample({super.key});

  @override
  State<AlertDialogboxExample> createState() => _AlertDialogboxExampleState();
}

class _AlertDialogboxExampleState extends State<AlertDialogboxExample> {
  void showAlertDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Simple Alert"),
            // content: Text("This is an alert dialogbox "),
            content: Container(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("OK")
              )
            ],

          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.blueAccent,
      //   title: Center(
      //       child: Text("AlertDialog box")
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/yoga1.jpeg')),
            Image(image: AssetImage('assets/yoga-plank.jpeg')),
            Center(
              child: SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: (){
                    showAlertDialog(context);
                  },
                  child: Text("Show Alert",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
