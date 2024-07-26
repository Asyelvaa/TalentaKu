import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/student_report_page/controllers/daily_report.controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

class ReportItem extends GetView<DailyReportController> {
  final String title;
  final String description;
  final String? indicator;
  const ReportItem({
    super.key,
    required this.title,
    required this.description,
    this.indicator,
  });

  @override
  Widget build(BuildContext context) {
    Widget reportWidget(String description, String point) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 220,
                  child: Text(
                    description,
                    style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: widthScreen * 0.01,
                  height: heightScreen * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColor.blue600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    point,
                    style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ExpansionTile(
        title: Text(title),
        children: [
          Obx(() => controller.isLoading.value
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: controller.reportData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = controller.reportData[index];
                    if (title == "Kegiatan Awal") {
                      return reportWidget(
                          data['kegiatan_awal'], data['awal_point']);
                    } else if (title == "Kegiatan Inti") {
                      return reportWidget(
                          data['kegiatan_inti'], data['inti_point']);
                    } else if (title == "Snack") {
                      return reportWidget(data['snack'], data['snack_point']);
                    } else if (title == "Kegiatan Inklusi") {
                      return reportWidget(
                          data['inklusi'], data['iklusi_point']);
                    } else if (title == "Catatan") {
                      return reportWidget(data['catatan'], 'muncul');
                    }
                    return Container();
                  }))
        ],
      ),
    );
  }
}
