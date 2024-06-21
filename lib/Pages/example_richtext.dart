import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class RichTextExample extends StatefulWidget {
  const RichTextExample({super.key});

  @override
  State<RichTextExample> createState() => _RichTextExampleState();
}

class _RichTextExampleState extends State<RichTextExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "RichText"
          ),
        ),
      ),

      body:
        // Center(
        //   child: Container(
        //     child: RichText(
        //       text: TextSpan(
        //         text: "Do you want to",
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 20,
        //         ),
        //         children: [
        //           TextSpan(
        //             text: " Sign up",
        //             style: TextStyle(
        //               color: Colors.blueAccent,
        //               fontSize: 20,
        //             ),
        //             recognizer: TapGestureRecognizer()
        //               ..onTap = () {}
        //           ),
        //         ]
        //       ),
        //     ),
        //   ),
        // )
      Center(
        child: RichText(
          text: TextSpan(
            text: "Don't have an account?",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: [
              TextSpan(
                text: " Sign up",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {}
              ),
            ]
          ),
        ),
      ),
    );
  }
}
