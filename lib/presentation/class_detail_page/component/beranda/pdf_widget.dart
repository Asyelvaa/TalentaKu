import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'package:url_launcher/url_launcher.dart';

class PDFWidget extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  PDFWidget({required this.fileUrl, required this.fileName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        final url = fileUrl;
        final uri = Uri.tryParse(url);
        if (uri != null && await launchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        child: Row(
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Text(
                fileName,
                style: AppTextStyle.tsBodyRegular(AppColor.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
