import 'package:flutter/material.dart';
class CardOneExample extends StatefulWidget {
  const CardOneExample({super.key});

  @override
  State<CardOneExample> createState() => _CardOneExampleState();
}

class _CardOneExampleState extends State<CardOneExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   title: Text("Habitual"),
      //   actions: [
      //     Icon(Icons.refresh),
      //   ],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 100,),
              ListTile(
                title: Center(
                  child: Text(
                    "Habitual",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                trailing: Icon(Icons.refresh),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  //color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Habit Diary",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Thu, 20 Feb 2020",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      Text(
                      "How are you feeling about your habits today?",
                        style: TextStyle(fontSize: 22,
                        color: Colors.grey,),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Container(
                            height: 70,
                            width: 390,
                            child: Column(
                              children: [
                                ListTile(
                                  leading:  Icon(Icons.emoji_emotions_outlined,
                                    color: Colors.green,
                                    size: 45,),
                                  title: Text("Stretches & Weights",
                                  style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Container(
                            height: 70,
                            width: 390,
                            child: Column(
                              children: [
                                ListTile(
                                  leading:  Icon(Icons.emoji_emotions_outlined,
                                    color: Colors.yellowAccent,
                                    size: 45,),
                                  title: Text("Walking",
                                    style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Container(
                            height: 70,
                            width: 390,
                            child: Column(
                              children: [
                                ListTile(
                                  leading:  Icon(Icons.emoji_emotions_outlined,
                                    color: Colors.green,
                                    size: 45,),
                                  title: Text("After noon food & drink",
                                    style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Container(
                            height: 70,
                            width: 390,
                            child: Column(
                              children: [
                                ListTile(
                                  leading:  Icon(Icons.emoji_emotions_outlined,
                                    color: Colors.red,
                                    size: 45,),
                                  title: Text("Evening food & drink",
                                    style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Container(
                            height: 70,
                            width: 390,
                            child: ListTile(
                              leading:  Icon(Icons.emoji_emotions_outlined,
                                color: Colors.green,
                                size: 45,),
                              title: Text("Snacks",
                                style: TextStyle(fontSize: 20),),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
