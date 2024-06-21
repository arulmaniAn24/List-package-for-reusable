import 'package:dynamic_form/src/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final void Function(List<String>) onChanged;
  final bool? isReadOnly;
  final String? hintText;
  final String? labelText;
  final bool? addNewEnabled;
  final bool Function(List<String>)? validator;

  const CustomMultiSelectDropdown({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.hintText,
    this.labelText,
    this.isReadOnly = false,
    this.validator,
    this.addNewEnabled = false,
  });

  @override
  State<CustomMultiSelectDropdown> createState() =>
      CustomMultiSelectDropdownState();
}

class CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  late List<bool> _isCheckedList;
  late TextEditingController _searchController;
  bool _selectAll = false;
  bool _isExpanded = false;
  List<String> _filteredOptions = [];
  String? _errorText;
  final List<int> _newItemIndices = [];

  @override
  void initState() {
    super.initState();
    _isCheckedList = List.generate(widget.options.length, (index) => false);
    _searchController = TextEditingController();
    _filteredOptions = widget.options;
  }

  void _filterOptions(String searchText) {
    setState(() {
      _filteredOptions = widget.options
          .where((option) =>
              option.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void _addNewItem(String newItem) {
    setState(() {
      widget.options.add(newItem);
      _isCheckedList.add(false);
      _filteredOptions = widget.options;
      _searchController.clear();
      _newItemIndices.add(widget.options.length - 1);
    });
  }

  void _editItem(int index, String newItem) {
    setState(() {
      widget.options[index] = newItem;
      _filteredOptions = widget.options;
    });
  }

  void _removeItem(int index) {
    setState(() {
      widget.options.removeAt(index);
      _isCheckedList.removeAt(index);
      _filteredOptions = widget.options;
      _newItemIndices.remove(index);
      for (int i = 0; i < _newItemIndices.length; i++) {
        if (_newItemIndices[i] > index) {
          _newItemIndices[i]--;
        }
      }
    });
  }

  String _selectedItemsText() {
    List<String> selectedItems = [];
    for (int i = 0; i < widget.options.length; i++) {
      if (_isCheckedList[i]) {
        selectedItems.add(widget.options[i]);
      }
    }
    return selectedItems.isEmpty
        ? widget.hintText ?? 'Select Options'
        : selectedItems.join(', ');
  }

  void _validateSelection() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(widget.selectedValues)
            ? null
            : 'Invalid selection';
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.labelText ?? 'Select Options',
              labelStyle: Styles.label_1,
              hintText: widget.hintText,
              hintStyle: Styles.hint_1,
              border: const OutlineInputBorder(),
              errorText: _errorText,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedItemsText(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Visibility(
          visible: _isExpanded,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 50 * 15,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterOptions,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    widget.addNewEnabled == true
                        ? Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add),
                                tooltip: "Add New",
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      TextEditingController newItemController =
                                          TextEditingController();
                                      return AlertDialog(
                                        title: const Text('Add New Item'),
                                        content: TextField(
                                          controller: newItemController,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter new item',
                                          ),
                                          onSubmitted: (value) {
                                            String newItem = value.trim();
                                            if (newItem.isNotEmpty) {
                                              _addNewItem(newItem);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              String newItem =
                                                  newItemController.text.trim();
                                              if (newItem.isNotEmpty) {
                                                _addNewItem(newItem);
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text('Add'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.select_all),
                                tooltip: "Select All",
                                onPressed: () {
                                  setState(() {
                                    _selectAll = !_selectAll;
                                    for (int i = 0;
                                        i < _isCheckedList.length;
                                        i++) {
                                      _isCheckedList[i] = _selectAll;
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.clear),
                                tooltip: "Clear All",
                                onPressed: () {
                                  setState(() {
                                    _isCheckedList = List.generate(
                                        widget.options.length,
                                        (index) => false);
                                  });
                                },
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredOptions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _isCheckedList[index] = !_isCheckedList[index];
                          });
                        },
                        child: ListTile(
                          title: Text(_filteredOptions[index]),
                          contentPadding: const EdgeInsets.all(0),
                          leading: Checkbox(
                            value: _isCheckedList[index],
                            onChanged: (bool? value) {
                              setState(() {
                                _isCheckedList[index] = value!;
                                if (_isCheckedList
                                    .every((isChecked) => isChecked)) {
                                  _selectAll = true;
                                } else {
                                  _selectAll = false;
                                }
                              });
                            },
                          ),
                          trailing: _newItemIndices.contains(index) &&
                                  widget.addNewEnabled == true
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            TextEditingController
                                                editController =
                                                TextEditingController(
                                                    text: _filteredOptions[
                                                        index]);
                                            return AlertDialog(
                                              title: const Text('Edit Item'),
                                              content: TextField(
                                                controller: editController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Enter new value',
                                                ),
                                                onSubmitted: (value) {
                                                  String newItem = value.trim();
                                                  if (newItem.isNotEmpty) {
                                                    _editItem(index, newItem);
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    String newItem =
                                                        editController.text
                                                            .trim();
                                                    if (newItem.isNotEmpty) {
                                                      _editItem(index, newItem);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text('Save'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _removeItem(index);
                                      },
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      List<String> selectedValues = [];
                      for (int i = 0; i < widget.options.length; i++) {
                        if (_isCheckedList[i]) {
                          selectedValues.add(widget.options[i]);
                        }
                      }
                      widget.onChanged(selectedValues);
                      setState(() {
                        _isExpanded = false;
                      });
                      _validateSelection();
                    },
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
