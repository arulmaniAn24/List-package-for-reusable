import 'package:flutter/material.dart';
class ExampleSnackBar extends StatefulWidget {
  const ExampleSnackBar({super.key});

  @override
  State<ExampleSnackBar> createState() => _ExampleSnackBarState();
}

class _ExampleSnackBarState extends State<ExampleSnackBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Snack Bar"),
          onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                   content: Text("This is SnackBar"))
               );
          },
        ),
      )
    );
  }
}
