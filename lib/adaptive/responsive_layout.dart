import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreen;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // if(constraints.maxWidth > 900) {
        //
        // }
        //return mobileScreen;
        return mobileScreen;
      },
    );
  }
}