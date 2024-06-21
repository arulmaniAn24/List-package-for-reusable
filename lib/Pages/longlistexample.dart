import 'package:flutter/material.dart';
class LongListExample extends StatefulWidget {
  const LongListExample({super.key});

  @override
  State<LongListExample> createState() => _LongListExampleState();
}

class _LongListExampleState extends State<LongListExample> {
  List<String> contacts = ["Diya", "Teju", "Methu","Karthik", "Geetha"];
  // var contacts = ["Diya", "Teju", "Methu","Karthik", "Geetha"];
  // var phonenos = [34567890, 34567890,98765432,76543243,];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Text(
            "Long List",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body:ListView.builder(
        itemCount: contacts.length,
          itemBuilder: (context, index){
          return ListTile(
            title: Text(contacts[index]),
            subtitle: Text("rtgyhujiko"),
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              radius: 25,
              child: Icon(Icons.person),
            ),
            trailing: Text("12:30 PM"),
          );
        }
      )
    );
  }
}