import 'package:first_app/Arestro/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _userNameController= TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _userNameKey = GlobalKey<FormFieldState>();
  final _phoneNumberKey = GlobalKey<FormFieldState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();

  String? _validateUsername(value) {
      if(value!.isEmpty){
        return "Please enter your name";
      }
      final RegExp alphaExp = RegExp(r'^[a-zA-Z]+$');

      if(!alphaExp.hasMatch(value)){
        return "Only Alphabets are allowed in a username";
      }
      return null;
    }

  String? _validateEmail(value){
    if(value!.isEmpty){
      return "Please enter email";
    }
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    if(!emailRegex.hasMatch(value)){
      return"Please enter a vaild email";
    }
    return null;
  }
  String? _validatePhoneNumber(value){
    if(value!.isEmpty){
      return "please enter phone number";
    }
    RegExp phoneRegex = RegExp(
        (r'^[0-9]{10}$')
    );
    if(!phoneRegex.hasMatch(value)){
      return "please enter valid phone number";
    }
    return null;
  }

  String? _validatePassword(value){
    if(value!.isEmpty){
      return "Please enter password";
    }
    return null;
  }

  void signUpAction() async{
    if (_formKey.currentState!.validate()) {
      final SharedPreferences prefs =  await SharedPreferences.getInstance();
      setState(() {
        prefs.setString('userName', _userNameController.text );
        prefs.setString('email', _emailController.text );
        prefs.setString('mobile', _phoneNumberController.text );
        prefs.setString('password', _passwordController.text );
        context.goNamed(RouteNames.dashboard);
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: SvgPicture.asset(
                      "assets/logo without name.svg",
                      height: 108,
                      width: 108,
                    ),
                  ),
                  SizedBox(height:10 ,),
                  Text(
                    "Create an account",
                    style: TextStyle(
                      color:HexColor("#000000"),
                      fontFamily: 'Manrope',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height:25 ,),
                  Container(
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      key: _userNameKey,
                      controller: _userNameController,
                      validator: _validateUsername,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter your username",
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
                        _userNameKey.currentState!.validate();
                      },
                    ),
                  ),
                  SizedBox(height:25,),
                  Container(
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: _emailController,
                      key: _emailFieldKey,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
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
                        _emailFieldKey.currentState!.validate();
                    }
                    ),
                  ),
                  SizedBox(height:25 ,),
                  Container(
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      key: _phoneNumberKey,
                      validator: _validatePhoneNumber,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your Phone Number",
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
                        _phoneNumberKey.currentState!.validate();
                      }
                    ),
                  ),
                  SizedBox(height:25 ,),
                  Container(
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blueAccent,
                          ),
                        ),
                        errorStyle: TextStyle(height: 0),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.remove_red_eye),
                        ),
                      ),
                      onFieldSubmitted: (_){
                        signUpAction();
                      },
                    ),
                  ),
                  SizedBox(height:30 ,),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor:HexColor("#009944"),
                      ),
                      onPressed: (){
                        signUpAction();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:10 ,),
                  Text("or continue with"),
                  SizedBox(height:20 ,),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Row(
                      children: [
                        Container(
                          // padding: EdgeInsets.only(left: 20),
                            height: 30,
                            width: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image(image: AssetImage('assets/google.jpeg'))
                        ),
                        SizedBox(width: 20,),
                        Text(
                          "SignUp with Google",
                          style: TextStyle(
                            color: HexColor("#000000"),
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:40 ,),
                  Container(
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(
                            color:HexColor("#0D0E0E"),
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                                text: "   LogIn",
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
