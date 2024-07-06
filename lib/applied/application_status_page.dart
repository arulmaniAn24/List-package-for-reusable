import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import 'application_timeline.dart';

class ApplicationStatusPage extends StatefulWidget {
  final String individual;
  final String laborWelfare;
  final String description;

  const ApplicationStatusPage({
    Key? key,
    required this.individual,
    required this.description,
    required this.laborWelfare,
  }) : super(key: key);

  @override
  State<ApplicationStatusPage> createState() => _ApplicationStatusPageState();
}

class _ApplicationStatusPageState extends State<ApplicationStatusPage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary2Color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.laborWelfare),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.individual,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: const BoxDecoration(color: AppColors.primary2Color),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Eligible For',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 16,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if (!isExpanded) {
                          eligibilityData =
                              await loadJsonData('assets/programs_json.json');
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
            ),
            if (isExpanded) const SizedBox(height: 2),
            if (isExpanded && eligibilityData != null) ...[
              const SizedBox(height: 2),
              _buildExpandSection(description, eligibilityDetails),
            ],
            const Divider(
              thickness: 1.5,
              color: AppColors.dividerColor,
              indent: 2,
              endIndent: 2,
            ),
            const Expanded(child: TimelinePage()),
          ],
        ),
      ),
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
