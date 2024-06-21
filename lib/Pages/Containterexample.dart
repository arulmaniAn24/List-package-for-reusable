import 'package:flutter/material.dart';
class ContainerExample extends StatefulWidget {
  const ContainerExample({super.key});

  @override
  State<ContainerExample> createState() => _ContainerExampleState();
}

class _ContainerExampleState extends State<ContainerExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Container"),
      ),
      body: Column(
        children: [
          SizedBox(height: 200,),
          Container(
            alignment: Alignment.center,
            width: 300,
            height: 300,
            margin: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 2),
              borderRadius: BorderRadius.circular(30),
              // color: Colors.yellow,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.3,
                  0.5,
                  0.9,
                ],
                colors: [
                  Colors.blue,
                  Colors.blue.shade50,
                  Colors.greenAccent,
                  Colors.green,
                ]
              ),
            ),
            child: Text("Google"),
          ),
        ],
      )
    );
  }
}
