import 'package:first_app/Pages/cardone_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class FoodExample extends StatefulWidget {
  const FoodExample({super.key});

  @override
  State<FoodExample> createState() => _FoodExampleState();
}

class _FoodExampleState extends State<FoodExample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 250,
                color: Colors.orangeAccent.shade200,
                child:Stack(
                  clipBehavior: Clip.none,
                  // fit: StackFit.expand,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        child:Image(image: AssetImage('assets/virat.png'),),
                      ),
                      trailing: Icon(
                        Icons.shopping_cart,
                      color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right:150.0,top: 90),
                      child: Text(
                        "Hello, Chromicle",
                        style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right:165.0,top: 150),
                      child: Text(
                          "Hunting for delious food?",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height:20),
                    Positioned(
                      bottom: -30,
                      right: 15,
                      left: 15,
                      child: Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search for anything",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:BorderSide(
                                  width: 4,
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                 //
              SizedBox(height: 60,),
              Container(
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Container(
                        width: 90,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Center(
                          child: Text(
                            "Burger",
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 90,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Center(child: Text("Noodels")),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 90,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Center(
                            child: Text("Biryani")
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 300,
              child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 100.0),
                                  child: Card(
                                    elevation: 5,
                                    // color: Colors.green,
                                    child: Container(
                                      height: 280,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/burger3.jpeg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 120.0, top: 10),
                                            child: Icon(
                                                Icons.favorite,
                                              color:Colors.white ,
                                            ),
                                          ),
                                          SizedBox(height: 150,),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 100.0),
                                            child: Text( "\$ 30",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 60.0),
                                            child: Text( "Chilli Cheese",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 100.0),
                                  child: Card(
                                    // color: Colors.green,
                                    elevation: 5,
                                    child: Container(
                                      height: 280,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/burger2.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 180.0,right: 40),
                                        child: Column(
                                          children: [
                                            Text(
                                                "\$ 18",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700
                                            ),
                                            ),
                                            Text(
                                              "Delish bloody",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ), 
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Text("Tab2"),
                      Text("Tab3"),
                    ]
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Text("1 Item(s)",
                            style: TextStyle(color: Colors.orangeAccent,
                                fontSize:25)),
                        Text("added to cart"),
                      ],
                    )
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        child: Text("Place order"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent.shade200,
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
