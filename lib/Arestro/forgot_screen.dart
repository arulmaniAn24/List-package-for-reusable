import 'package:first_app/Arestro/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _emailController = TextEditingController();

  String? _validateEmail(value){
    if(value!.isEmpty){
      return "Please enter email";
    }
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    if(!emailRegex.hasMatch(value)){
      return "Please enter a vaild email";
    }
    return null;
  }
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();

  SnackBar showSnackBar(String message){
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.redAccent,
      showCloseIcon: true,
    );
  }

  void forgotAction() async{
    if(_formKey.currentState!.validate()){
      final SharedPreferences prefs =  await SharedPreferences.getInstance();
      setState(() {
        if(prefs.getString('email') == _emailController.text){
          context.goNamed(RouteNames.resetPassword);
        }
        else{
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Email not registered"));
        }
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 108,
                    width: 108,
                    margin: EdgeInsets.only(top: 40),
                    child: SvgPicture.asset(
                      "assets/logo without name.svg",
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 33,
                    width: 194,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        color:HexColor("#000000"),
                        fontFamily: 'Manrope',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 36,
                    width: 281,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Don't worry, It happens. Please enter the email associated with your account",
                      style: TextStyle(
                        color:HexColor("#000000"),
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: _emailController,
                      key: _emailKey,
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        hintText: "Enter your email address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blueAccent,
                          ),
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                        onFieldSubmitted: (_){
                          forgotAction();
                      }
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 55,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor:HexColor("#009944"),
                      ),
                      onPressed: (){
                        forgotAction();
                        },
                      child: Text(
                        "Send Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 280,),
                  Container(
                    child: RichText(
                      text: TextSpan(
                          text: "Remember Password?",
                          style: TextStyle(
                            color:HexColor("#0D0E0E"),
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                                text: "LogIn",
                                style: TextStyle(
                                  color:HexColor("#2F89FC"),
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed(RouteNames.startup);
                                  }
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
