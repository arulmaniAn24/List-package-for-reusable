import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  bool isSwitched = false;

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  Widget companyLogo(isExpanded) {
    return Row(
      mainAxisAlignment: (isExpanded) ? MainAxisAlignment.start: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.only(left: 20),
            height: 50,
            width: 50,
            child: Image(
                image: AssetImage('assets/avatar.png'))
        ),
        SizedBox(width: 10,),
        Text(
          "UI Unicorn",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                )
              ]
          ),
        )
      ],
    );
  }
  Widget loginForm(bool isExpanded, double forgotTextSize){
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LayoutBuilder(builder: (context, constraints){
            if(isExpanded) {
              return companyLogo(isExpanded);
            }
            return SizedBox(width: 0,);
          }),
          SizedBox(height: 25,),
          Container(
            padding: const EdgeInsets.only(left: 20),
            width: double.maxFinite,
            child: Text(
              "Nice to see you again",
              textAlign: TextAlign.start,
              style: TextStyle(
                color:HexColor("#000000"),
                fontFamily: 'Manrope',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15,),
          LayoutBuilder(
              builder: (context, constraints){
                if(isExpanded){
                  return Container(
                    padding: const EdgeInsets.only(left: 25),
                    width: double.maxFinite,
                    child: Text(
                      "Login",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: HexColor("#000000"),
                        fontFamily: 'Poppins-Medium',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                else{
                  return SizedBox(width: 0,);
                }
              }),
          SizedBox(height: 15,),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: HexColor('#E5E5E5'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email or phone number",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                errorStyle: TextStyle(height: 0),

              ),
            ),
          ),
          SizedBox(height: 15,),
          LayoutBuilder(
              builder: (context, constraints){
                if(isExpanded){
                  return Container(
                    padding: const EdgeInsets.only(left: 25),
                    width: double.maxFinite,
                    child: Text(
                      "Password",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: HexColor("#000000"),
                        fontFamily: 'Poppins-Medium',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                else{
                  return SizedBox(width: 0,);
                }
              }),
          SizedBox(height: 15,),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: HexColor('#E5E5E5'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter password",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.remove_red_eye),
                ),
                errorStyle: TextStyle(height: 0),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: isSwitched,
                        onChanged: _toggleSwitch,
                      ),),

                    Text(
                      "remember me",
                      style: TextStyle(
                        color:HexColor("#1A1A1A"),
                        fontFamily: 'Manrope',
                        fontSize: forgotTextSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color:HexColor("#007AFF"),
                          fontFamily: 'Manrope',
                          fontSize: forgotTextSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor:HexColor("#007AFF"),
              ),
              onPressed: (){
              },
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 35,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(height: 1, color: Colors.grey[400]),
          ),
          SizedBox(height: 35,),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: HexColor('#333333'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    // color: Colors.black,
                    margin: const EdgeInsets.only(right: 10),
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image(image: AssetImage('assets/google.png'),)
                ),
                SizedBox(width: 25,),
                Text(
                  "or sign in with Google",
                  style: TextStyle(
                    color: HexColor("#FFFFFF"),
                    fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
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
                        text: "     "
                    ),
                    TextSpan(
                      text: "Sign up now",
                      style: TextStyle(
                        color:HexColor("#2F89FC"),
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]
              ),
            ),
          ),
          SizedBox(height: 50,),
          LayoutBuilder(builder: (context, constraints) {
            if(!isExpanded) {
              return companyLogo(isExpanded);
            } else {
              return SizedBox(width: 0,);
            }
          }),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = (MediaQuery.of(context).size.width > 900) ? true : false;
    double forgotTextSize = 10;
    if(MediaQuery.of(context).size.width > 375 && MediaQuery.of(context).size.width < 425){
      forgotTextSize = 14;
    } else if(MediaQuery.of(context).size.width > 425 && MediaQuery.of(context).size.width < 900) {
      forgotTextSize = 15;
    } else if(MediaQuery.of(context).size.width > 900) {
      forgotTextSize = 12;
    }

    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constrains){
            if(isExpanded){
              return  Row(
                children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/background.png'),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                        child: loginForm(isExpanded,forgotTextSize )
                    ),
                  ),
                ],
              );
            }
            else{
              return SingleChildScrollView(
                child: loginForm(isExpanded, forgotTextSize),
              );
            }
          }),
    );
  }
}
