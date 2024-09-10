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
    List<dynamic> arrayKegiatan = controller.singleReportData[fieldName];
    String point =
        fieldPoint == 'none' ? 'none' : controller.singleReportData[fieldPoint];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              title,
              style: AppTextStyle.tsNormal,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: arrayKegiatan.map<Widget>((report) {
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
        ],
      ),
    );
  }

  Widget reportWidget(String fieldName, String fieldPoint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // width: Get.width * 0.6,
          child: Text(
            fieldName,
            style: AppTextStyle.tsNormal,
            maxLines: 3,
          ),
        ),
        fieldPoint == 'none'
            ? SizedBox(
                width: 0,
                height: 0,
              )
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
