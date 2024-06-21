import 'package:first_app/Pages/exampletextformfield.dart';
import 'package:first_app/Pages/gridbuilder_example.dart';
import 'package:first_app/Pages/longlistexample.dart';
import 'package:flutter/material.dart';
class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExample();
}

class _TabBarExample extends State<TabBarExample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("T A B B A R" ),
            actions: [
              Icon(Icons.add_circle_outlined),
              SizedBox(width: 20,),
              Icon(Icons.search),
              SizedBox(width: 20,),
              Icon(Icons.message),
              SizedBox(width: 20,),
            ],
            bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                        Icons.contacts,
                        size: 30,
                        color: Colors.purpleAccent
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.person,
                        size: 30,
                        color: Colors.purpleAccent
                    ),
                  ),
                  Tab(
                    icon: Icon(
                        Icons.access_alarm,
                        size: 30,
                        color: Colors.purpleAccent
                    ),
                  )
                ]
            ),
          ),
          body: TabBarView(
              children: [
                GridBuliderExample(),
                ExampleTextFormField(),
                LongListExample(),
              ]
          ),
        ),
    );
  }
}
