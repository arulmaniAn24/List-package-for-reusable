import 'package:dynamic_form/src/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomRadioButtonList extends StatefulWidget {
  const CustomRadioButtonList({
    required this.items,
    required this.onSelected,
    super.key,
    this.isReadOnly,
    this.hintText,
    this.labelText,
    this.isHorizontal,
  });
  final String? hintText;
  final bool? isReadOnly;
  final bool? isHorizontal;
  final String? labelText;
  final List<String> items;
  final ValueChanged<String?> onSelected;

  @override
  CustomRadioButtonListState createState() => CustomRadioButtonListState();
}

class CustomRadioButtonListState extends State<CustomRadioButtonList> {
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: widget.isHorizontal != null && widget.isHorizontal!
          ? GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 6),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                widget.items.length,
                (index) {
                  return RadioListTile(
                    groupValue: _selectedValue,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue[300],
                    dense: true,
                    title: Text(
                      widget.items[index],
                      style: Styles.label_1,
                    ),
                    value: widget.items[index],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value;
                        widget.onSelected(value);
                      });
                    },
                  );
                },
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: RadioListTile(
                    groupValue: _selectedValue,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue[300],
                    dense: true,
                    title: Text(
                      widget.items[index],
                      style: Styles.label_1,
                    ),
                    value: widget.items[index],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value;
                        widget.onSelected(value);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
