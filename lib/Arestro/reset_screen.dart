import 'package:first_app/Arestro/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _validatePassword(value){
    if(value!.isEmpty){
      return "Please enter password";
    }
    return null;
  }

  String? _validateConfirmPassword(value){
    if(value!.isEmpty){
      return "Please enter confirm password";
    }
    if(value!= _passwordController.text){
      return "Passwords do not match";
    }
    return null;
  }

  SnackBar showSnackBar(String message){
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: HexColor("#009944"),
      showCloseIcon: true,
    );
  }

  void resetAction() async{
    if(_formKey.currentState!.validate()){
      final SharedPreferences prefs =  await SharedPreferences.getInstance();
      setState(() {
        prefs.setString("password", _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Password reset successful!"));
        context.goNamed(RouteNames.login);
      });

    }
  }

  final _formKey = GlobalKey<FormState>();
  final _newPasswordKey = GlobalKey<FormFieldState>();
  final _repeatNewPasswordKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 108,
                    width: 108,
                    margin: EdgeInsets.only(top: 50),
                    child: SvgPicture.asset(
                      "assets/logo without name.svg",
                    ),
                  ),
                  Container(
                    height: 33,
                    width: 194,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Reset Password",
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
                    height: 18,
                    width: 281,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Please write something you'll remember",
                      style: TextStyle(
                        color:HexColor("#000000"),
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      key: _newPasswordKey,
                      textInputAction: TextInputAction.next,
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        hintText: "Enter New Password ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blueAccent,
                          ),
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: double.maxFinite,
                    child: TextFormField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      validator: _validateConfirmPassword,
                      decoration: InputDecoration(
                        hintText: "Repeat New Password",
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
                        resetAction();
                      },
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
                        resetAction();
                        },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
