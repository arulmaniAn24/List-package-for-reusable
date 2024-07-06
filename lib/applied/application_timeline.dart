import 'dart:convert';
import 'package:beneficiary_package/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  late Map<String, dynamic> _jsonData = {};

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    String data = await rootBundle.loadString('assets/timeline_json.json');
    setState(() {
      _jsonData = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _jsonData.isNotEmpty
        ? Stack(
            children: [
              Positioned(
                left: 173,
                top: 6,
                bottom: 0,
                child: Container(
                  width: 2,
                  color: Colors.blueGrey[50],
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                children: [
                  _buildTimelineEvent(
                      'Application', _jsonData['status']['application']),
                  _buildTimelineEvent(
                      'Verification', _jsonData['status']['verification']),
                  _buildTimelineEvent(
                      'Approval', _jsonData['status']['approval']),
                ],
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget _buildTimelineEvent(String title, Map<String, dynamic> eventData) {
    final bool isApproval = title == 'Approval';
    final bool isCompleted = eventData['status'] == 'Completed';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                eventData['applied_on'],
                style: const TextStyle(
                    color: AppColors.secondary7Color,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 8),
              Container(
                width: 1,
                height: 120,
                color: Colors.transparent,
              ),
            ],
          ),
          const SizedBox(width: 14),
          if (isCompleted)
            Container(
              width: 2,
              height: 120,
              color: isCompleted
                  ? AppColors.primaryColor
                  : AppColors.divider1Color,
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isApproval
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    eventData['description'],
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.secondary7Color,
                        fontFamily: 'Poppins'),
                  ),
                  if (eventData['status'].isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(eventData['status']),
                      backgroundColor: isCompleted
                          ? AppColors.primaryColor
                          : AppColors.primary2Color,
                      labelStyle: TextStyle(
                          color: isCompleted
                              ? AppColors.backgroundColor
                              : AppColors.secondary6Color,
                          fontFamily: 'Poppins'),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
