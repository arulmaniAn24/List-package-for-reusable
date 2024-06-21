import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                            "assets/images/ot.svg",
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
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Pinput(
                        length: 4,
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset("assets/images/resbut.svg"),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    GestureDetector(
                      child: SvgPicture.asset("assets/images/reotp.svg"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
            ),
        );
    }
}
