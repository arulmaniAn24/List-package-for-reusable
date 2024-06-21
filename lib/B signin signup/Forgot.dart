import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  int selectedContainer = 0;
  void selectContainer(int containerIndex) {
    setState(() {
      selectedContainer = containerIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                          alignment: Alignment(0, -0.4),
                          child: SvgPicture.asset(
                            "assets/images/forgot.svg",
                          ))),
                  Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment(0, 0.2),
                            child: SvgPicture.asset(
                              "assets/images/entp.svg",
                            )),
                      )),
                ],
              ),
              SizedBox(
                height: 67,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectContainer(1);
                      },
                      child: Container(
                        width: 400,
                        height: 100,
                        color: selectedContainer == 1 ? Colors.green : Colors.white,
                        child: Center(
                          child: SvgPicture.asset("assets/images/fa.svg"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectContainer(2);
                      },
                      child: Container(
                        width: 677,
                        height: 100,
                        color: selectedContainer == 2 ? Colors.green : Colors.white,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/images/faa.svg",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46,
                    ),
                    GestureDetector(
                      child: SvgPicture.asset("assets/images/resbut.svg"),
                      onTap: () {
                        context.go("/Otp");
                      },
                    ),
                  ],
                ),
              )
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 36,
              //         ),
              //         Center(
              //           child: InkWell(
              //             child: SvgPicture.asset("assets/images/2FA.svg"),
              //             onTap: () {
              //               setState(() {
              //               selectedContainer = index;
              //               });
              //             },
              //           ),
              //         ),
              //         SizedBox(
              //           height: 36,
              //         ),
              //         GestureDetector(
              //           child: SvgPicture.asset("assets/images/2FAA.svg"),
              //           onTap: () {},
              //         ),
              //         SizedBox(
              //           height: 56,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              // child: GestureDetector(
              //   child: SvgPicture.asset("assets/images/reset.svg"),
              //   onTap: () {
              //     context.go("/Otp");
              //   },
              // ),
              //      ),
              //       ],
              //     ),
              //   )
            ],
            ),
        );
    }
}
