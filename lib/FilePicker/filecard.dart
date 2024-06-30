import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

class FileCard extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final VoidCallback? onCancel;

  const FileCard({
    super.key,
    required this.fileName,
    required this.fileSize,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.primary2Color,
        border: Border.all(color: AppColors.secondary3Color),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: SvgPicture.asset(
                    getFileTypeImage(fileName),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.02,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary2Color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fileSize,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onCancel,
              child: SvgPicture.asset(
                'assets/images/cancel.svg',
                height: MediaQuery.of(context).size.height * 0.018,
                width: MediaQuery.of(context).size.width * 0.01,
                color: AppColors.secondary4Color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getFileTypeImage(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'assets/images/pdf.svg';
      case 'doc':
      case 'docx':
        return 'assets/images/docs.svg';
      case 'xls':
      case 'xlsx':
        return 'assets/images/excel.svg';
      default:
        return 'assets/images/file.svg';
    }
  }
}
