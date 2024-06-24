import 'package:flutter/material.dart';

class ViewToggleButton extends StatelessWidget {
  final Function() onViewChanged;

  ViewToggleButton({required this.onViewChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.swap_horiz),
      onPressed: onViewChanged,
    );
  }
}
