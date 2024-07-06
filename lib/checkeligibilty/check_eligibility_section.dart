import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class EligibilityCheckSection extends StatefulWidget {
  const EligibilityCheckSection({super.key});

  @override
  _EligibilityCheckSectionState createState() =>
      _EligibilityCheckSectionState();
}

class _EligibilityCheckSectionState extends State<EligibilityCheckSection> {
  bool isExpanded = false;
  Map<String, dynamic>? eligibilityData;
  String eligibilityDetails = "";
  String description = "";

  Future<Map<String, dynamic>> loadJsonData(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  String formatEligibilityDetails(Map<String, dynamic> data) {
    final eligibility = data['eligibility'];
    List<String> details = [
      "Age: ${eligibility['Age']}",
      "Children: ${eligibility['Children']}",
      "Children Studying: ${eligibility['Children Studying']}",
      "Community: ${eligibility['Community']}",
      "Economic Status: ${eligibility['Economic Status']}",
      "Gender: ${eligibility['Gender']}",
      "Income: ${eligibility['Income']}",
      "Location: ${eligibility['Location']}",
      "Marital Status: ${eligibility['MaritalStatus']}",
      "Occupation: ${eligibility['Occupation']}",
      "Resident Status: ${eligibility['ResidentStatus']}",
    ];

    return details.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final eligibilityChecks = [
      _buildEligibilityCheckCard(
        "Labor Welfare",
        "Individual",
        "Eligible For",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          ...ListTile.divideTiles(
            context: context,
            tiles: eligibilityChecks.map((card) => card).toList(),
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildEligibilityCheckCard(
    String laborWelfare,
    String individual,
    String eligibleFor,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: AppColors.primary2Color,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          laborWelfare,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(
                          height: 28,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              side: const BorderSide(
                                color: AppColors.secondary7Color,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                            ),
                            child: const Text(
                              'Applied',
                              style: TextStyle(
                                color: AppColors.secondary6Color,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      individual,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.secondary7Color,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eligibleFor,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 16,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (!isExpanded) {
                              eligibilityData = await loadJsonData(
                                  'assets/programs_json.json');
                              eligibilityDetails =
                                  formatEligibilityDetails(eligibilityData!);
                              description = eligibilityData!['description'];
                            }
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(
                            isExpanded ? 'Show less' : 'Show more',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded) const SizedBox(height: 8),
                ],
              ),
            ),
            if (isExpanded && eligibilityData != null) ...[
              const SizedBox(height: 4),
              _buildExpandSection(description, eligibilityDetails),
            ],
            const Divider(
              thickness: 1.5,
              color: AppColors.dividerColor,
              indent: 16,
              endIndent: 16,
            ),
          ],
        );
      },
    );
  }

  Widget _buildExpandSection(String description, String eligibilityDetails) {
    return Card(
      color: AppColors.primary2Color,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              eligibilityDetails,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
