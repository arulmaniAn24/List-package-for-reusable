import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  final void Function(String) onSearchChanged;

  SearchFilter({required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
