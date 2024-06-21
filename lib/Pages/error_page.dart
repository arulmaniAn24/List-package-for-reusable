import 'package:first_app/Pages/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page") ,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            context.goNamed(RouteNames.dashboard);
          }, child: Text("Home"),
        ),
      ),
    );
  }
}
