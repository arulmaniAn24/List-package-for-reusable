import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewToggleButton extends StatelessWidget {
  final Function() onViewChanged;
  final bool isTableView;

  ViewToggleButton({required this.onViewChanged, required this.isTableView});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewChanged,
      child: _buildIconButton(
        isTableView: isTableView,
        onTap: onViewChanged,
      ),
    );
  }

  Widget _buildIconButton({
    required bool isTableView,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE9EBF2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSvgIcon(
              assetPath: 'assets/images/tableview.svg',
              isActive: isTableView,
            ),
            const SizedBox(width: 16.0),
            _buildSvgIcon(
              assetPath: 'assets/images/gridview.svg',
              isActive: !isTableView,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgIcon({
    required String assetPath,
    required bool isActive,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: 15,
      height: 15,
      color: isActive ? const Color(0xFF1F397A) : const Color(0xFF727272),
    );
  }
}
