import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class ListExample extends StatefulWidget {
  const ListExample({super.key});

  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Basic List"
        ),
      ),
      body: ListView(
        // scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 150.0,
            color: Colors.red,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
          ),
          Container(
            width: 150.0,
            color: Colors.grey,
            child: ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Alarm'),
            ),
          ),
          Container(
            width: 150.0,
            color: Colors.blue,
            child: ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
            ),
          ),
          Container(
            width: 150.0,
            color: Colors.yellow,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                // GoRouter.of(context).go("/");
                context.go("/");
              },
              child: Text("Dashboard"),)
        ],
      ),
      // body: ListView(
      //   // scrollDirection: Axis.horizontal,
      //   children: [
      //     Container(
      //       // width: 100.0,
      //       height: 50.0,
      //       color: Colors.blue,
      //       child: ListTile(
      //         title: Text("Contacts"),
      //         leading: Icon(Icons.contacts),
      //       ),
      //     ),
      //     ListTile(
      //       title: Text("Contacts"),
      //       leading: Icon(Icons.contacts),
      //     ),
      //     ListTile(
      //       title: Text("Contacts"),
      //       leading: Icon(Icons.contacts),
      //     ),
      //     ListTile(
      //       title: Text("Contacts"),
      //       leading: Icon(Icons.contacts),
      //     ),
      //
      //   ],
      // ),
    );
  }
}
