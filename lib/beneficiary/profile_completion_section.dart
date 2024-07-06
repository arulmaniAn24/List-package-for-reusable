import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/colors.dart';

class ProfileCompletionSection extends StatelessWidget {
  const ProfileCompletionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildProfileCompletionRow(
              "Basic Profile", "assets/images/checkcircle.svg", "100%"),
          _buildProfileCompletionRow("Economic Profile", null, "40%"),
          _buildProfileCompletionRow("Disability", null, "50%"),
        ],
      ),
    );
  }

  Widget _buildProfileCompletionRow(
      String title, String? iconSvgPath, String percentage) {
    return Card(
      color: AppColors.primary2Color,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            if (iconSvgPath != null)
              SvgPicture.asset(
                iconSvgPath,
                width: 24,
                height: 24,
              )
            else
              Text(
                percentage,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
