import 'package:dynamic_form/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDropdown extends StatefulWidget {
  final String? hintText;
  final bool? isReadOnly;
  final String? labelText;
  final List<String> items;
  final ValueChanged<String?> onSelected;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onSelected,
    this.isReadOnly,
    this.hintText,
    this.labelText,
  });

  @override
  State<CustomDropdown> createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;
  late TextEditingController _searchController;
  bool _isDropdownOpen = false;
  final Set<String> _newlyAddedItems = {};

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.items.first;
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {});
          },
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
          readOnly: widget.isReadOnly ?? false,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: Styles.label_1,
            hintText: widget.hintText,
            hintStyle: Styles.hint_1,
            border: const OutlineInputBorder(),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        Null;
                      });
                    },
                    icon: const Icon(Icons.clear),
                  )
                : Icon(_isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
          ),
        ),
        if (_isDropdownOpen)
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView(
              children: [
                ...widget.items.where((item) {
                  return item
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase());
                }).map<Widget>((item) {
                  return ListTile(
                    title: Text(
                      item,
                      style: Styles.input_1,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedItem = item;
                        _searchController.text = item;
                        _isDropdownOpen = false;
                      });
                      widget.onSelected(item);
                    },
                    trailing: _newlyAddedItems.contains(item)
                        ? IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                widget.items.remove(item);
                                _newlyAddedItems.remove(item);
                                if (_selectedItem == item) {
                                  _selectedItem = null;
                                }
                              });
                            },
                          )
                        : null,
                  );
                }),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.add_new_field,
                    style: Styles.heading_2,
                  ),
                  onTap: () {
                    _showAddItemDialog(context);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    String? newItem;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            onChanged: (value) {
              newItem = value;
            },
            decoration: const InputDecoration(hintText: 'Enter new item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (newItem != null && newItem!.isNotEmpty) {
                  setState(() {
                    widget.items.add(newItem!);
                    _selectedItem = newItem;
                    _searchController.text = newItem!;
                    _isDropdownOpen = false;
                    widget.onSelected(newItem!);
                    _newlyAddedItems.add(newItem!);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
