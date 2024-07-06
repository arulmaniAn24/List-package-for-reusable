import 'package:flutter/material.dart';

import '../constants/colors.dart';

class FamilyMembersSection extends StatelessWidget {
  const FamilyMembersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final familyMembers = [
      _buildFamilyMemberCard("J", "Jyothi", "Wife"),
      _buildFamilyMemberCard("P", "Pooja", "Daughter"),
      _buildFamilyMemberCard("B", "Ben", "Son"),
      _buildFamilyMemberCard("L", "Lakshmi", "Mother"),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 3 / 2,
        children: familyMembers,
      ),
    );
  }

  Widget _buildFamilyMemberCard(String initial, String name, String relation) {
    return Card(
      color: AppColors.primary2Color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary3Color,
                  child: Text(initial),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    relation,
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
