import 'package:dynamic_form/src/themes/themes.dart';
import 'package:flutter/material.dart';

class MultiDropdownWidget extends StatefulWidget {
  const MultiDropdownWidget({
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    super.key,
    this.hintText,
    this.labelText,
    this.isReadOnly = false,
  });

  final bool? isReadOnly;
  final String? hintText;
  final String? labelText;
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onChanged;

  @override
  State<MultiDropdownWidget> createState() => _MultiDropdownWidgetState();
}

class _MultiDropdownWidgetState extends State<MultiDropdownWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _showDropdown = false;
  late List<String> filteredItems;
  late List<String> localSelectedItems;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.selectedItems.join(', '));
    _focusNode = FocusNode();
    filteredItems = widget.items;
    localSelectedItems = List.from(widget.selectedItems);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _showDropdown = !_showDropdown;
      if (_showDropdown) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    });
  }

  void _toggleSelectedItem(bool isReadOnly, String item) {
    setState(() {
      if (!isReadOnly) {
        if (localSelectedItems.contains(item)) {
          localSelectedItems.remove(item);
        } else {
          localSelectedItems.add(item);
        }
        _controller.text = localSelectedItems.join(', ');
        widget.onChanged(localSelectedItems);
      }
    });
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredItems = widget.items;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) {
            if (widget.isReadOnly!) {
              _filterItems(value);
              _showDropdown = true;
              setState(() {});
            }
          },
          readOnly: widget.isReadOnly ?? false,
          decoration: InputDecoration(
            labelText: widget.labelText ?? '',
            labelStyle: Styles.label_1,
            hintText: widget.hintText ?? '',
            hintStyle: Styles.hint_1,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
              onPressed: widget.isReadOnly! ? () {} : _toggleDropdown,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (_showDropdown)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    _toggleSelectedItem(widget.isReadOnly!, item);
                  },
                  leading: Checkbox(
                    value: localSelectedItems.contains(item),
                    onChanged: (value) {
                      _toggleSelectedItem(widget.isReadOnly ?? false, item);
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
