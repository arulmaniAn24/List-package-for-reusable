import 'package:first_app/Pages/dashboard.dart';
import 'package:first_app/Pages/welcomepage.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffefeeee)
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Text(
                "Access Key",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 50,),
              Text(
                "Login into your account",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20,top: 20),
                child:  TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20,top: 20),
                child:  TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 150, right: 150),
                    backgroundColor: Colors.blue
                  ),
                  onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage(_email.text)));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard()));
                  },
                  child: Text(
                      "Sign in",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                  "Or sign in with"
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: ExactAssetImage(),
                    //     fit: BoxFit.fitHeight,
                    //   ),
                    // ),
                    child: Text("G"),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: Text("F"),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: Text("A"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
