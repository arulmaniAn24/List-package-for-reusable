import 'package:dynamic_form/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final DateFormat dateFormat;
  final TextEditingController controller;
  final void Function(DateTime?)? onDateChanged;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;

  const CustomDatePicker({
    super.key,
    required this.labelText,
    required this.dateFormat,
    required this.controller,
    this.onDateChanged,
    this.validator,
    this.decoration,
  });

  @override
  State<CustomDatePicker> createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  String? _errorText;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = widget.dateFormat.format(_selectedDate!);
        _errorText = widget.validator?.call(widget.controller.text);
      });
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(_selectedDate);
      }
    }
  }

  void _handleDateInput(String input) {
    try {
      final parsedDate = widget.dateFormat.parseStrict(input);
      setState(() {
        _selectedDate = parsedDate;
        _errorText = widget.validator?.call(input);
      });
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(_selectedDate);
      }
    } catch (e) {
      setState(() {
        _errorText = "Invalid date format";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: widget.decoration?.copyWith(
            labelText: widget.labelText,
            errorText: _errorText,
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ) ??
          InputDecoration(
            labelText: widget.labelText,
            errorText: _errorText,
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ),
      keyboardType: TextInputType.datetime,
      inputFormatters: [DateTextInputFormatter()],
      onChanged: _handleDateInput,
    );
  }
}
