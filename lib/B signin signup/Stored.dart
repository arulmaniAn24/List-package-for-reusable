import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'SignUp.dart';



class Stored extends StatefulWidget {
  const Stored({super.key});

  @override
  State<Stored> createState() => _StoredState();
}

class _StoredState extends State<Stored> {
  String _storedEmail ="";
  String _storedPassword ="";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override

  void initState(){
    super.initState();
    _retrieveStoredCredentials();
    emailController.text = _storedEmail;
    passController.text = _storedPassword;
  }

  Future<void> _retrieveStoredCredentials() async{
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('user_email') ?? "";
    final storedPassword = prefs.getString('user_password') ?? "";
    setState(() {
      _storedEmail = storedEmail;
      _storedPassword = storedPassword;
    });
    Future<void> _saveCredentials() async {
      if(emailController.text.isNotEmpty && passController.text.isNotEmpty){
        setState(() {
          _storedEmail = emailController.text;
          _storedPassword = passController.text;
        });
        print("old email: $_storedEmail");
        print("old password: $_storedPassword");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', _storedEmail);
        await prefs.setString('user_password', _storedPassword);
      }
      else{
        print("please enter thr email and password");
      }
    }
    @override
    void dispose(){
      emailController.dispose();
      passController.dispose();
      super.dispose();
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("DATA"),centerTitle: true,),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        
          children: [
            Text('Email: $_storedEmail') ,
            Text('Password: $_storedPassword') ,
            SizedBox(height: 23,),
          
                            MaterialButton(
                              child: Text("Back"),color: Colors.blue,
                              onPressed: (){
                              context.go("/SignUp");
                              
                            })
                   ],
        ),
      ),

    );
  }
}