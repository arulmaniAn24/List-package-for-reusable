import 'dart:io';

import 'package:dynamic_form/src/models/models.dart';
import 'package:dynamic_form/src/themes/themes.dart';
import 'package:dynamic_form/src/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DynamicFormWidget extends StatefulWidget {
  const DynamicFormWidget({
    required this.currentLanguage,
    super.key,
    this.data,
    this.islast,
    this.isReadOnly = false,
  });
  final String currentLanguage;
  final FormFields? data;
  final bool? islast;
  final bool? isReadOnly;

  @override
  State<DynamicFormWidget> createState() => _DynamicFormWidgetState();
}

class _DynamicFormWidgetState extends State<DynamicFormWidget> {
  Map<String, dynamic> fieldValuesMap = {};
  void createControllersAndValues() {
    if (widget.data == null ||
        widget.data!.type == null ||
        widget.data!.fieldValue == null) return;

    switch (widget.data!.type!) {
      case 'text':
        fieldValuesMap[widget.data!.fieldValue!] = TextEditingController();
        break;
      case 'single_select_dropdown':
      case 'radio_button':
        fieldValuesMap[widget.data!.fieldValue!] = '';
        break;
      case 'multi_select_dropdown':
        fieldValuesMap[widget.data!.fieldValue!] = <String>[];
        break;
      case 'single_select_checkbox_list':
      case 'multi_select_checkbox_list':
        fieldValuesMap[widget.data!.fieldValue!] = <CheckBoxListModel>[];
        break;
      case 'date':
        fieldValuesMap[widget.data!.fieldValue!] = TextEditingController();
        break;
      case 'date_range':
        fieldValuesMap[widget.data!.fieldValue!] = DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );
        break;
      case 'single_image_picker':
      case 'multi_image_picker':
        fieldValuesMap[widget.data!.fieldValue!] = <File>[];
        break;
    }
  }

  @override
  void initState() {
    createControllersAndValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // print("Controller fields:");
      // fieldValuesMap.forEach((key, value) {
      //   print("Key: $key, Value: $value");
      // });
    }

    final TextEditingController textController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

    final question = widget.data?.labels
        ?.firstWhere((x) => x.language == widget.currentLanguage);

    final hint = widget.data?.placeHolder
        ?.firstWhere((x) => x.language == widget.currentLanguage)
        .value;

    List<Object?>? optionItems;
    if (widget.data?.type != null && widget.data!.type!.contains('checkbox')) {
      optionItems = widget.data?.optionType == 'text'
          ? widget.data?.options
              ?.where((x) => x.language == widget.currentLanguage)
              .map((e) => CheckBoxListModel(title: e.value!, isCheck: false))
              .toList()
          : widget.data?.options
              ?.map((e) => CheckBoxListModel(title: e.value!, isCheck: false))
              .toList();
    } else {
      optionItems = widget.data?.optionType == 'text'
          ? widget.data?.options
              ?.where((x) => x.language == widget.currentLanguage)
              .map((e) => e.value)
              .toList()
          : widget.data?.options;
    }

    var mandatory = widget.data?.validations?.firstWhere(
        (x) => x.containsKey('mandatory'),
        orElse: () => null)?['mandatory'];

    var horizontal = widget.data?.validations?.firstWhere(
        (x) => x.containsKey('horizontal'),
        orElse: () => null)?['horizontal'];

    if (kDebugMode) {
      print('>> data: ${widget.data?.type} || $optionItems');
      print('>> mandatory: $mandatory || horizontal : $horizontal');
    }

    void onDateChanged(DateTime? date) {
      fieldValuesMap[widget.data!.fieldValue!] = date;
      if (kDebugMode) {
        print("Selected date: $date");
        print(
            "date value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
      }
    }

    void onDateRangeChanged(DateTimeRange? dateRange) {
      if (dateRange != null) {
        fieldValuesMap[widget.data!.fieldValue!] = dateRange;
        if (kDebugMode) {
          print("Selected date range: ${dateRange.start} to ${dateRange.end}");
          print(
              "date value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
        }
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${question?.value}',
                    style: Styles.label_1,
                  ),
                ),
                mandatory
                    ? Image.asset(
                        "assets/icons/ic_asterisk.png",
                        height: 8,
                        width: 8,
                        color: Colors.red,
                        fit: BoxFit.fitWidth,
                      )
                    : const SizedBox()
              ],
            ),
            if (widget.data?.type == 'text')
              CustomTextField(
                onChanged: (value) {
                  fieldValuesMap[widget.data!.fieldValue!] = value;
                  if (kDebugMode) {
                    print(
                        "textController value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                  }
                },
                controller: textController,
                keyboardType: widget.data?.keyboardType == 'phone'
                    ? TextInputType.phone
                    : TextInputType.text,
                isReadOnly: widget.data?.isReadOnly ?? false,
                textInputAction: widget.islast == true
                    ? TextInputAction.done
                    : TextInputAction.next,
                hint: hint,
              )
            else if (widget.data?.type == 'single_select_dropdown')
              optionItems != null && optionItems.isNotEmpty == true
                  ? CustomDropdown(
                      hintText: hint ?? '',
                      isReadOnly: widget.data?.isReadOnly ?? false,
                      items: List<String>.from(optionItems),
                      onSelected: (String? value) {
                        fieldValuesMap[widget.data!.fieldValue!] = value;
                        if (kDebugMode) {
                          print(
                              "single_select_dropdown value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                        }
                      },
                    )
                  : Text(
                      'Options or not provided',
                      style: Styles.heading_3,
                    )
            else if (widget.data?.type == 'multi_select_dropdown')
              optionItems != null && optionItems.isNotEmpty == true
                  ? CustomMultiSelectDropdown(
                      hintText: hint ?? '',
                      isReadOnly: widget.data?.isReadOnly ?? false,
                      addNewEnabled: widget.data?.valueRestricted == false,
                      onChanged: (List<String> value) {
                        fieldValuesMap[widget.data!.fieldValue!] = value;
                        if (kDebugMode) {
                          print(
                              "multi_select_dropdown value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                        }
                      },
                      options: List<String>.from(optionItems),
                      selectedValues: const [],
                    )
                  : Text(
                      'Options or not provided',
                      style: Styles.heading_3,
                    )
            else if (widget.data?.type != null &&
                widget.data!.type!.contains('checkbox'))
              optionItems != null && optionItems.isNotEmpty == true
                  ? CustomCheckBoxList(
                      labelText: question?.value ?? '',
                      hintText: hint ?? '',
                      isReadOnly: widget.data?.isReadOnly ?? false,
                      isSingleSelect:
                          widget.data?.type == 'single_select_checkbox_list',
                      isHorizontal: horizontal,
                      items: List<CheckBoxListModel>.from(optionItems),
                      onSelected: (List<CheckBoxListModel>? value) {
                        fieldValuesMap[widget.data!.fieldValue!] = value ?? [];
                        if (kDebugMode) {
                          print(value!.map((e) => e.title));
                          print(
                              "checkbox_list value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                        }
                      },
                    )
                  : Text(
                      'Options or not provided',
                      style: Styles.heading_3,
                    )
            else if (widget.data?.type == 'radio_button')
              optionItems != null && optionItems.isNotEmpty == true
                  ? CustomRadioButtonList(
                      labelText: question?.value ?? '',
                      hintText: hint ?? '',
                      isReadOnly: widget.data?.isReadOnly ?? false,
                      isHorizontal: horizontal,
                      items: List<String>.from(optionItems),
                      onSelected: (String? value) {
                        fieldValuesMap[widget.data!.fieldValue!] = value;
                        if (kDebugMode) {
                          print(
                              "radio_button value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                        }
                      },
                    )
                  : Text(
                      'Options or not provided',
                      style: Styles.heading_3,
                    )
            else if (widget.data?.type == 'date')
              CustomDatePicker(
                labelText: 'Enter Date (DD/MM/YYYY)',
                dateFormat: DateFormat('dd/MM/yyyy'),
                controller: dateController,
                onDateChanged: onDateChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'End Date',
                  hintText: 'DD/MM/YYYY',
                ),
              )
            else if (widget.data?.type == 'date_range')
              CustomDateRangePicker(
                startLabelText: 'Start Date (DD/MM/YYYY)',
                endLabelText: 'End Date (DD/MM/YYYY)',
                dateFormat: DateFormat('dd/MM/yyyy'),
                startDateController: startDateController,
                endDateController: endDateController,
                onDateRangeChanged: onDateRangeChanged,
                startDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Start Date',
                  hintText: 'DD/MM/YYYY',
                ),
                endDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'End Date',
                  hintText: 'DD/MM/YYYY',
                ),
              )
            else if (widget.data?.type == 'single_image_picker')
              CustomImagePicker(
                labelText: question?.value ?? '',
                hintText: hint ?? '',
                isReadOnly: widget.data?.isReadOnly ?? false,
                multiSelect: false,
                onSelected: (List<File>? files) {
                  fieldValuesMap[widget.data!.fieldValue!] = files;
                  if (kDebugMode) {
                    print(files!.map((e) => e));
                    print(
                        "single_image_picker value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                  }
                },
              )
            else if (widget.data?.type == 'multi_image_picker')
              CustomImagePicker(
                labelText: question?.value ?? '',
                hintText: hint ?? '',
                isReadOnly: widget.data?.isReadOnly ?? false,
                multiSelect: true,
                onSelected: (List<File>? files) {
                  if (files != null && files.isNotEmpty) {
                    fieldValuesMap[widget.data!.fieldValue!] = files.first;
                    if (kDebugMode) {
                      print(files.map((e) => e));
                      print(
                          "multi_image_picker value of ${widget.data!.fieldValue}: ${fieldValuesMap[widget.data!.fieldValue!]}");
                    }
                  }
                },
              )
            // else if (data?.type == 'file_picker')
            //   CustomFilePicker(
            //     labelText: question?.value ?? '',
            //     hintText: hint ?? '',
            //     isReadOnly: data?.isReadOnly ?? false,
            //     multiSelect: true,
            //     onSelected: (List<File>? files) {},
            //   )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
