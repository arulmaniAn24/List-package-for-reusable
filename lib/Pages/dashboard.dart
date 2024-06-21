import 'package:first_app/Pages/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            "Dashboard",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              // simple route
              // onPressed: (){
              //   context.go("/routes-example");
              // },

              //Route parameter or path parameter
              // onPressed: (){
              //   final String name = "Mythili";
              //   context.go("/routes-example/$name");
              // },

              // named route
              // onPressed: (){
              //   context.goNamed(RouteNames.routeExample);
              // },

              // Query parameter
              onPressed: (){
                context.goNamed(
                  RouteNames.routeExample,
                  queryParameters: {
                    "username":"Mythili"
                  }
                );
              },
              // onPressed: (){
              //   context.goNamed(
              //       RouteNames.routeExample,
              //   );
              // },
              child: Text("Routes Example"),
            ),
          )
        ],
      ),
    );
  }
}
