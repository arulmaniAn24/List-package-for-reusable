import 'package:first_app/Pages/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class RoutesExample extends StatefulWidget {
  final String name;
  // const RoutesExample({
  //   super.key,
  // });
  RoutesExample({
    super.key,
    required this.name
  });

  @override
  State<RoutesExample> createState() => _RoutesExampleState();
}

class _RoutesExampleState extends State<RoutesExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            "Routes",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome ${widget.name}",
            // "Welcome",
            style: TextStyle(
              fontSize: 30
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              onPressed: (){
                context.goNamed(RouteNames.dashboard);
              },
              child: Text("Dashboard"),
            ),
          )
        ],
      ),
    );
  }
}
