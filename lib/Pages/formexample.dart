import 'package:first_app/Pages/welcomepage.dart';
import 'package:flutter/material.dart';
class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _mobileno = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your full name',
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _mobileno,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mobile',
                hintText: 'Enter your mobileno',
              ),
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>WelcomePage(name: _name.text, mobileno: _mobileno.text,)
                ));
              }, child: Text("Submit"))

        ],
      ),
    );
  }
}
