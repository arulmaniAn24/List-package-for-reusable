import 'package:flutter/material.dart';

import '../../dynamic_home.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    required this.controller,
    super.key,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSuffixIconPressed,
    this.focusNode,
    this.autofocus = false,
    this.contentPadding,
    this.isReadOnly = false,
    this.bgColor,
    required this.widget,
  });
  final BodyWidget widget;
  final Color? bgColor;
  final TextEditingController controller;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixIconPressed;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool? isReadOnly;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final props = widget.bodyWidgetProps!;
    return Container(
      color: bgColor ?? Colors.grey[200],
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: props.height?.toDouble() ?? 45,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
            bottom: props.margin!.bottom?.toDouble() ?? 16,
            top: props.margin!.top?.toDouble() ?? 16,
            right: props.margin!.right?.toDouble() ?? 16,
            left: props.margin!.left?.toDouble() ?? 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: isReadOnly ?? false,
          textInputAction: textInputAction,
          onChanged: onChanged,
          focusNode: focusNode,
          autofocus: autofocus,
          showCursor: false,
          enableSuggestions: true,
          decoration: InputDecoration(
              hintText: hint ?? 'Search',
              prefixIcon: Icon(prefixIcon ?? Icons.search),
              border: InputBorder.none,
              contentPadding: contentPadding ?? const EdgeInsets.only(top: 10)),
        ),
      ),
    );
  }
}
