import 'package:first_app/Arestro/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  String? _validatePassword(value){
    if(value!.isEmpty){
      return "Please enter password";
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  bool isChecked = false;

  SnackBar showSnackBar(String message,color){
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: color,
      showCloseIcon: true,
    );
  }
  void loginAction() async{
    if(_formKey.currentState!.validate()){
      final SharedPreferences prefs =  await SharedPreferences.getInstance();
      setState(() {
       if(prefs.getString('email') == _emailController.text ){
         if(prefs.getString('password') == _passwordController.text){
           ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Login successful", HexColor("#009944")));
           context.goNamed(RouteNames.dashboard);
         } else {
           ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Incorrect password", Colors.redAccent));
         }
       }
       else{
         ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Email not registered", Colors.redAccent));
       }
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: SvgPicture.asset(
                          height: 108,
                          width: 108,
                          "assets/logo without name.svg",
                        ),
                      ),
                      // const SizedBox(height: 10,width: double.maxFinite,),
                      Text(
                        "Log In",
                        style: TextStyle(
                          color:HexColor("#000000"),
                          fontFamily: 'Manrope',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: double.maxFinite,
                    child: Text(
                        "Email",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: HexColor("#000000"),
                        fontFamily: 'Poppins-Medium',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                  height: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.maxFinite,
                  child: TextFormField(
                    controller: _emailController,
                    key: _emailFieldKey,
                    validator: _validateEmail,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "example@gmail.com",
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
                    },
                  ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: double.maxFinite,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: HexColor("#000000"),
                        fontFamily: 'Poppins-Medium',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: _passwordController,
                      key: _passwordFieldKey,
                      obscureText: true,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blueAccent,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.remove_red_eye),
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                      onFieldSubmitted: (_){
                        loginAction();
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.black,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value){
                            setState(() {
                              isChecked = value!;
                            });
                          }
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            text: "Remember me",
                            style: TextStyle(
                              color:HexColor("#000000"),
                              fontFamily: 'Manrope',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                  text: "  Forgot Your Password?",
                                  style: TextStyle(
                                    color:HexColor("#E86969"),
                                    fontFamily: 'Manrope',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.goNamed(RouteNames.forgotPassword);
                                    }
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
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
                        loginAction();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),
                  Text("or continue with"),
                  SizedBox(height: 30,),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Row(
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image(image: AssetImage('assets/google.jpeg'))
                        ),
                        SizedBox(width: 30,),
                        Text(
                          "Login with Google",
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
                  SizedBox(height: 50,),
                  Container(
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            color:HexColor("#0D0E0E"),
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                                text: "   Sign up",
                                style: TextStyle(
                                  color:HexColor("#2F89FC"),
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  context.goNamed(RouteNames.signup);
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
