import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/text_background.dart';
import 'controllers/daily_report.controller.dart';
import 'component/report_item.dart';

class DailyReportScreen extends GetView<DailyReportController> {
  DailyReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final report = controller.getReportById(reportId);

    // if (report == null) {
    //   return Scaffold(
    //     backgroundColor: AppColor.background,
    //     appBar: AppBar(
    //       leading: IconButton(
    //         onPressed: () {
    //           Get.back();
    //         },
    //         icon: Icon(
    //           Icons.arrow_back,
    //           color: AppColor.white,
    //         ),
    //       ),
    //       backgroundColor: AppColor.blue600,
    //     ),
    //     body: Center(
    //       child: Text("Report not found"),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.white,
          ),
        ),
        backgroundColor: AppColor.blue600,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Obx(
          () => controller.isLoading.value == true
              ? Center(
                  child: Text("Report not found"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // HEADER
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.blue600,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 30, top: 10, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Laporan harian",
                                style: AppTextStyle.tsTitle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  TextWithBackground(
                                    colorBackground: AppColor.white,
                                    text:
                                        "Semester ${controller.singleReportData['semester_id']}",
                                  ),
                                  SizedBox(width: 10),
                                  TextWithBackground(
                                    colorBackground: AppColor.white,
                                    text:
                                        "${controller.singleReportData['created']}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ReportItem(
                        title: "Kegiatan Awal",
                        data: [controller.singleReportData],
                        fieldName: 'kegiatan_awal',
                        fieldPoint: 'awal_point',
                      ),
                      ReportItem(
                        title: "Kegiatan Inti",
                        data: [controller.singleReportData],
                        fieldName: 'kegiatan_inti',
                        fieldPoint: 'inti_point',
                      ),
                      ReportItem(
                        title: "Snack",
                        data: [controller.singleReportData],
                        fieldName: 'snack',
                        fieldPoint: 'snack_point',
                      ),
                      ReportItem(
                        title: "Kegiatan Inklusi",
                        data: [controller.singleReportData],
                        fieldName: 'inklusi',
                        fieldPoint: 'inklusi_point',
                      ),
                      ReportItem(
                        title: "Catatan",
                        data: [controller.singleReportData],
                        fieldName: 'catatan',
                        fieldPoint: 'catatan_point',
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
