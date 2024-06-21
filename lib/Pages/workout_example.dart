import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WorkoutExample extends StatefulWidget {
  const WorkoutExample({
    super.key,
  });

  @override
  State<WorkoutExample> createState() => _WorkoutExampleState();
}

class _WorkoutExampleState extends State<WorkoutExample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Image(image: AssetImage('assets/virat.png'),),
                ),
                title: Text(
                    "Hello Virat",
                  style: TextStyle(
                      fontSize:25,
                      fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                    "Ready to workout?",
                style: TextStyle(
                    fontSize:30,
                    fontWeight: FontWeight.w700),
                ),
                trailing: Icon(Icons.notifications_none),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                child: Container(
                  color: Colors.grey.shade100,
                  height: 70,
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite_border_sharp),
                                  SizedBox(width: 10,),
                                  Text(
                                    "Heart Rate",
                                    style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // Text("Heart Rate"),
                              Text(
                                "81 BPM",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(width: 15,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.list),
                                  SizedBox(width: 10,),
                                  Text(
                                    "To-do",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // Text("Heart Rate"),
                              Text(
                                  "32.5%",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(width: 15,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.child_friendly_outlined),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Care",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Text("Heart Rate"),
                                Text(
                                  "1000 cal",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 120.0),
                child: Text(
                    "Workout Programs",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                child: Container(
                  height: 60,
                  width: 500,
                  color: Colors.grey.shade100,
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text("All Type"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text("Full Body"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text("Upper"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text("Lower"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:20 ,),
              Container(
                height: 220,
                width: 400,
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 50),
                      child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: Text(
                                    "7 days",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Text(
                                  "Morning Yoga",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Text(
                                "Improve mental foccus",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 90.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    Icon(Icons.access_time_rounded),
                                    SizedBox(width: 10,),
                                    Text(
                                        "30 mins",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),),
                                    // SizedBox(width: 180,),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: 120,
                        width: 130,
                        child:Row(
                          children: [
                            Image(image: AssetImage('assets/yoga1.jpeg'))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(8),
                height: 210,
                width: 400,
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 50),
                      child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: Text(
                                  "3 days",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Text(
                                  "Plank Exercise",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Text(
                                "Improve posture and stability",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 90.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    Icon(Icons.access_time_rounded),
                                    SizedBox(width: 10,),
                                    Text(
                                      "30 mins",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),),
                                    // SizedBox(width: 180,),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(width:10,),
                    Container(
                      // color: Colors.red,
                      height: 80,
                      width: 150,
                      child:Row(
                        children: [
                          Image(image: AssetImage('assets/yoga-plank.jpeg')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
