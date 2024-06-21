import 'package:flutter/material.dart';
class SnackBarExample extends StatefulWidget {
  const SnackBarExample({super.key});

  @override
  State<SnackBarExample> createState() => _SnackBarExampleState();
}

class _SnackBarExampleState extends State<SnackBarExample> {
   final snackBar = SnackBar(
     content: Text(
       "Hey! This is a SnackBar message.",
       style: TextStyle(color: Colors.black),
     ),
     duration: Duration(seconds: 5),
     action: SnackBarAction(
         label: "Undo",
         textColor: Colors.red,
         onPressed: (){
           // code to undo action
         }
         ),
     backgroundColor: Colors.orangeAccent,
     showCloseIcon: true,
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Text(
            "S n a c k B a r"
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            "Show Snack Bar",
            style: TextStyle(color: Colors.white,fontSize: 30),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
