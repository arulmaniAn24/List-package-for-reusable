import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  final String separator;
  final String dateFormat;

  DateTextInputFormatter(
      {this.separator = '/', this.dateFormat = 'dd/MM/yyyy'});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove any existing separators
    newText = newText.replaceAll(separator, '');

    // Add separators according to the date format
    if (newText.length > 2) {
      newText = newText.substring(0, 2) + separator + newText.substring(2);
    }
    if (newText.length > 5) {
      newText = newText.substring(0, 5) + separator + newText.substring(5);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
