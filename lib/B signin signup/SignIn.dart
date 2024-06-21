import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  

  

  void _SignIn() async {
    if (_formfield.currentState?.validate() ?? true) {
      final email = emailController.text;
      final password = passController.text;
      
     
      await _storeCredentials(email, password);
      final storedEmail = await _retrieveEmail();
      print('Stored email: $storedEmail');
      context.go("/Stored_Data");
    }
  }
  Future<void> _storeCredentials(String email, String password) async{
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
 }
  Future<String?> _retrieveEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/images/BG.svg",
                      width: 375,
                      height: 219,
                    ),
                    Positioned.fill(
                        child: Align(
                            alignment: const Alignment(0, -0.4),
                            child: SvgPicture.asset(
                              "assets/images/sg.svg",
                            ))),
                    Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: const Alignment(0, 0.2),
                              child: SvgPicture.asset(
                                "assets/images/ll.svg",
                              )),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formfield,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Email Address",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Enter your email address...',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            validator: (value) {
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?_`{|}~]+@[a-zA-Z0-9]"
                                  r"+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value.isEmpty) {
                                return "Enter email";
                              } else if (!emailValid) {
                                return "Enter valid email";
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: passController,
                            obscureText: passToggle,
                            decoration: InputDecoration(
                              labelText: 'Enter your password...',
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              } else if (passController.text.length < 6) {
                                return "Password should be more than 6 characters ";
                              }
                            }),
                        const SizedBox(
                          height: 29,
                        ),
                        ElevatedButton(
                          onPressed: _SignIn,
                          child: SvgPicture.asset(
                            "assets/images/sgbut.svg",
                            width: 700,
                            height: 76,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SvgPicture.asset("assets/images/r.svg"),
                        const SizedBox(
                          height: 23,
                        ),
                        SvgPicture.asset("assets/images/fff.svg"),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            const SizedBox(
                              width: 7,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go("/SignUp");
                              },
                              child: const Text("Sign Up"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset("assets/images/frp.svg"),
                          onTap: () {
                            context.go("/Forgot");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
