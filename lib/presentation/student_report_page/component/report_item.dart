import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/student_report_page/controllers/daily_report.controller.dart';
import 'package:get/get.dart';

class ReportItem extends GetView<DailyReportController> {
  final String title;
  final dynamic data;
  final String fieldName;
  final String fieldPoint;

  ReportItem({
    required this.title,
    required this.data,
    required this.fieldName,
    required this.fieldPoint,
  });

  @override
  Widget build(BuildContext context) {
    // Map<dynamic, dynamic> dataMap = data;
    List<dynamic> arrayKegiatan = controller.singleReportData[fieldName];
    String point =
        fieldPoint == 'none' ? '' : controller.singleReportData[fieldPoint];

    // for (var item in datas) {
    //   if (title == "Kegiatan Awal") {
    //     arrayKegiatan.add(item['kegiatan_awal']);
    //   } else if (title == "Kegiatan Inti") {
    //     arrayKegiatan.add(item['kegiatan_inti']);
    //   } else if (title == "Snack") {
    //     arrayKegiatan.add(item['snack']);
    //   } else if (title == "Inklusi") {
    //     arrayKegiatan.add(item['inklusi']);
    //   }
    // }
    // if (title == "Kegiatan Awal") {
    //   point = data['awal_point'];
    // } else if (title == "Kegiatan Inti") {
    //   point = data['inti_point'];
    // } else if (title == "Snack") {
    //   point = data['snack_point'];
    // } else if (title == "Inklusi") {
    //   point = data['inklusi_point'];
    // }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          hintColor: Colors.transparent,
          unselectedWidgetColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: AppTextStyle.tsNormal,
          ),
          children: arrayKegiatan!.map<Widget>((report) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  reportWidget(
                    report ?? 'N/A',
                    point ?? 'N/A',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: AppColor.black,
                    height: 1,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget reportWidget(String fieldName, String fieldPoint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: Get.width * 0.6,
          child: Text(
            fieldName,
            style: AppTextStyle.tsNormal,
            maxLines: 3,
          ),
        ),
        fieldPoint.trim().toLowerCase() == 'none'
            ? SizedBox.shrink()
            : Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.blue500,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  fieldPoint,
                  style: AppTextStyle.tsLittle.copyWith(color: AppColor.white),
                ),
              ),
      ],
    );
  }
}
