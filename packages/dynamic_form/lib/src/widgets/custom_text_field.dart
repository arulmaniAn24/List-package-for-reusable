import 'package:dynamic_form/src/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    this.label,
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
  });
  final TextEditingController controller;
  final String? label;
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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: isReadOnly ?? false,
      textInputAction: textInputAction,
      onChanged: onChanged,
      focusNode: focusNode,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Styles.label_1,
        hintText: hint,
        hintStyle: Styles.hint_1,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
        contentPadding: contentPadding,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
