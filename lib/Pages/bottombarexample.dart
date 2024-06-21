import 'package:first_app/Pages/exampletextformfield.dart';
import 'package:first_app/Pages/grid_example.dart';
import 'package:first_app/Pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BottomBarExample extends StatefulWidget {
  const BottomBarExample({super.key});

  @override
  State<BottomBarExample> createState() => _BottomBarExampleState();
}

class _BottomBarExampleState extends State<BottomBarExample> {
  int index = 0;
  final tab = [
    Login(),
    GridExample(),
    ExampleTextFormField(),
    // Center(
    //   child:
    //     Text("Home"),
    // ),
    // Center(
    //   child:
    //   Text("Updates"),
    // ),
    // Center(
    //   child:
    //   Text("Search"),
    // )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text("Bottom Bar")),
      ),
      body: tab[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.red,
        // iconSize: 30,
        selectedItemColor: Colors.black,
        selectedFontSize: 25,
        unselectedFontSize: 20,
        currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.redAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update_sharp),
              label: "Updates",
              backgroundColor: Colors.purpleAccent
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.orange,
            ),
          ],
          onTap: (current_index){
          setState(() {
            index = current_index;
            print(index);
          });
    },
      ),
    );
  }
}
