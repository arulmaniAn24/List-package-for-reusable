import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class ExampleTextFormField extends StatefulWidget {
  const ExampleTextFormField({super.key});

  @override
  State<ExampleTextFormField> createState() => _ExampleTextFormFieldState();
}

class _ExampleTextFormFieldState extends State<ExampleTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
            child: Text("Textformfield")
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blueAccent,
                      )
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.person),
                  ),
                  labelText: 'Name',
                  hintText: 'Enter your full name',
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.phone),
                ),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
              ),
              ),
            ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 3,color: Colors.blueAccent,
                      ),
                    ),
                    icon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                      },
                    ),
                    hintText: "DOB",
                    labelText: "DD/MM/YYYY",
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: 400,
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.grey,
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 20),),

                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your number",
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(
                    //   width: 3,
                    //   color: Colors.blueAccent,
                    // ),

                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your number",
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(
                    //   width: 3,
                    //   color: Colors.blueAccent,
                    // ),

                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your number",
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(
                    //   width: 3,
                    //   color: Colors.blueAccent,
                    // ),

                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your number",
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(
                    //   width: 3,
                    //   color: Colors.blueAccent,
                    // ),

                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
