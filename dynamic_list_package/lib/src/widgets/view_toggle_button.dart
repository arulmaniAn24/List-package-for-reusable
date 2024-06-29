import 'package:flutter/material.dart';

class ViewToggleButton extends StatelessWidget {
  final Function() onViewChanged;
  final bool isTableView;

  ViewToggleButton({required this.onViewChanged, required this.isTableView});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(
          icon: Icons.grid_view,
          isActive: !isTableView,
          onTap: () {
            if (isTableView) {
              onViewChanged();
            }
          },
        ),
        _buildIconButton(
          icon: Icons.view_list,
          isActive: isTableView,
          onTap: () {
            if (!isTableView) {
              onViewChanged();
            }
          },
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required bool isActive,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF1F397A) : Color(0xFFE9EBF2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Color(0xFF1F397A),
        ),
      ),
    );
  }
}
