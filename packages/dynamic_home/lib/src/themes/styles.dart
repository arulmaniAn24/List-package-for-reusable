import 'package:flutter/material.dart';

mixin Styles {
  static TextStyle heading_1 = const TextStyle(
    fontFamily: null,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle heading_2 = const TextStyle(
    fontFamily: null,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading_3 = const TextStyle(
    fontFamily: null,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle hint_1 = const TextStyle(
    fontFamily: null,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle input_1 = const TextStyle(
    fontFamily: null,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle label_1 = const TextStyle(
    fontFamily: null,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle navigation(Color color) {
    return TextStyle(
      fontFamily: null,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
}
