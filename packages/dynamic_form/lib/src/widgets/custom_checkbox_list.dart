import 'package:dynamic_form/src/src.dart';
import 'package:dynamic_form/src/themes/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxList extends StatefulWidget {
  const CustomCheckBoxList({
    required this.items,
    required this.onSelected,
    super.key,
    this.isReadOnly,
    this.hintText,
    this.labelText,
    this.isHorizontal,
    this.isSingleSelect,
  });
  final String? hintText;
  final bool? isReadOnly;
  final bool? isHorizontal;
  final bool? isSingleSelect;
  final String? labelText;
  final List<CheckBoxListModel> items;
  final ValueChanged<List<CheckBoxListModel>?> onSelected;

  @override
  CustomCheckBoxListState createState() => CustomCheckBoxListState();
}

class CustomCheckBoxListState extends State<CustomCheckBoxList> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('>> items: ${widget.items[0].title} | ${widget.isSingleSelect}');
    }
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
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue[300],
                    dense: true,
                    title: Text(
                      widget.items[index].title,
                      style: Styles.label_1,
                    ),
                    value: widget.items[index].isCheck,
                    onChanged: (bool? val) {
                      itemChange(index, value: val);
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
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue[300],
                    dense: true,
                    title: Text(
                      widget.items[index].title,
                      style: Styles.label_1,
                    ),
                    value: widget.items[index].isCheck,
                    onChanged: (bool? val) {
                      itemChange(index, value: val);
                    },
                  ),
                );
              },
            ),
    );
  }

  void itemChange(int index, {bool? value}) {
    setState(() {
      if (widget.isSingleSelect!) {
        for (final x in widget.items) {
          x.isCheck = false;
        }
      }
      widget.items[index].isCheck = value ?? false;
      final selectedItems = widget.items.where((item) => item.isCheck).toList();
      widget.onSelected(selectedItems);
    });
  }
}
