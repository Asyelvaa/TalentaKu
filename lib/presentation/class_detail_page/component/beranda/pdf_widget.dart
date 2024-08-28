import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/pdf_viewer_screen.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFWidget extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  PDFWidget({required this.fileUrl, required this.fileName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.to(() => PDFViewerScreen(fileUrl: fileUrl, fileName: fileName));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02), 
        child: Row(
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
            ),
            SizedBox(width: screenWidth * 0.03), // Responsive spacing
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
