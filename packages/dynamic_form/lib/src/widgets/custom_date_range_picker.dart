import 'package:dynamic_form/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  final String startLabelText;
  final String endLabelText;
  final DateFormat dateFormat;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final void Function(DateTimeRange?)? onDateRangeChanged;
  final InputDecoration? startDecoration;
  final InputDecoration? endDecoration;

  const CustomDateRangePicker({
    super.key,
    required this.startLabelText,
    required this.endLabelText,
    required this.dateFormat,
    required this.startDateController,
    required this.endDateController,
    this.onDateRangeChanged,
    this.startDecoration,
    this.endDecoration,
  });

  @override
  State<CustomDateRangePicker> createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTimeRange? _selectedDateRange;
  String? _startErrorText;
  String? _endErrorText;

  Future<void> dateTimeRangePicker(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
        start: DateTime.now(),
      ),
      builder: (context, child) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: child!,
                )
              ],
            ),
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
        widget.startDateController.text =
            widget.dateFormat.format(_selectedDateRange!.start);
        widget.endDateController.text =
            widget.dateFormat.format(_selectedDateRange!.end);
        _startErrorText = null;
        _endErrorText = null;
      });
      if (widget.onDateRangeChanged != null) {
        widget.onDateRangeChanged!(_selectedDateRange);
      }
    }
  }

  void _selectDateRange(BuildContext context) async {
    await dateTimeRangePicker(context);
  }

  void _handleStartDateInput(String input) {
    _startErrorText = null;
    _endErrorText = null;
    try {
      final parsedStartDate = widget.dateFormat.parseStrict(input);
      DateTime parsedEndDate = _selectedDateRange?.end ?? parsedStartDate;

      if (widget.endDateController.text.isNotEmpty) {
        parsedEndDate =
            widget.dateFormat.parseStrict(widget.endDateController.text);
      }

      if (parsedStartDate.isAfter(parsedEndDate)) {
        setState(() {
          _startErrorText = "Start date cannot be after end date";
        });
      } else {
        setState(() {
          _selectedDateRange =
              DateTimeRange(start: parsedStartDate, end: parsedEndDate);
        });
        if (widget.onDateRangeChanged != null) {
          widget.onDateRangeChanged!(_selectedDateRange);
        }
      }
    } catch (e) {
      setState(() {
        _startErrorText = "Invalid date format";
      });
    }
  }

  void _handleEndDateInput(String input) {
    _startErrorText = null;
    _endErrorText = null;
    try {
      final parsedEndDate = widget.dateFormat.parseStrict(input);
      DateTime parsedStartDate = _selectedDateRange?.start ?? parsedEndDate;

      if (widget.startDateController.text.isNotEmpty) {
        parsedStartDate =
            widget.dateFormat.parseStrict(widget.startDateController.text);
      }

      if (parsedStartDate.isAfter(parsedEndDate)) {
        setState(() {
          _endErrorText = "End date cannot be before start date";
        });
      } else {
        setState(() {
          _selectedDateRange =
              DateTimeRange(start: parsedStartDate, end: parsedEndDate);
        });
        if (widget.onDateRangeChanged != null) {
          widget.onDateRangeChanged!(_selectedDateRange);
        }
      }
    } catch (e) {
      setState(() {
        _endErrorText = "Invalid date format";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.startDateController,
            decoration: widget.startDecoration?.copyWith(
                  labelText: widget.startLabelText,
                  errorText: _startErrorText,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateRange(context),
                  ),
                ) ??
                InputDecoration(
                  labelText: widget.startLabelText,
                  errorText: _startErrorText,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateRange(context),
                  ),
                ),
            keyboardType: TextInputType.datetime,
            inputFormatters: [DateTextInputFormatter()],
            onChanged: _handleStartDateInput,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            controller: widget.endDateController,
            decoration: widget.endDecoration?.copyWith(
                  labelText: widget.endLabelText,
                  errorText: _endErrorText,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateRange(context),
                  ),
                ) ??
                InputDecoration(
                  labelText: widget.endLabelText,
                  errorText: _endErrorText,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateRange(context),
                  ),
                ),
            keyboardType: TextInputType.datetime,
            inputFormatters: [DateTextInputFormatter()],
            onChanged: _handleEndDateInput,
          ),
        ),
      ],
    );
  }
}
