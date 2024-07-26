import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/student_report_page/component/report_item.dart';
import 'package:flutter_talentaku/presentation/student_report_page/controllers/daily_report.controller.dart';

import '../global_component/back_appbar.dart';
import '../global_component/text_background.dart';

class DailyReportScreen extends GetView<DailyReportController> {
  DailyReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.white,
            )),
        backgroundColor: AppColor.blue600,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.blue600,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 30, top: 10, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Laporan harian",
                        style: AppTextStyle.tsTitle.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.white)),
                    SizedBox(height: 5),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (controller.errorMessage.isNotEmpty) {
                        return Center(
                            child: Text(controller.errorMessage.value));
                      } else if (controller.reportData.isEmpty) {
                        return Center(
                            child: Text('tidak ada data yang ditampilkan'));
                      } else {
                        final data = controller.reportData[0];
                        return Row(
                          children: [
                            TextWithBackground(
                              colorBackground: AppColor.white,
                              text: "Semester ${data['semester_id']}",
                            ),
                            SizedBox(width: 10),
                            TextWithBackground(
                              colorBackground: AppColor.white,
                              text: "${data['created']}",
                            ),
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.reportData.isEmpty) {
                return Center(child: Text('tidak ada data yang ditampilkan'));
              } else {
                // return Container(
                //     height: Get.height,
                //     width: Get.width,
                //     child: ListView.builder(
                //       itemCount: controller.reportData.length,
                //       itemBuilder: (context, index) {
                //         final report = controller.reportData[index];
                //         return ReportItem(
                //           title: "Kegiatan Awal",
                //           description:
                //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                //           indicator: "Muncul",
                //         );
                //       },
                //     ));
                return Column(
                  children: [
                    ReportItem(
                      title: "Kegiatan Awal",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                      indicator: "Muncul",
                    ),
                    ReportItem(
                      title: "Kegiatan Inti",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                      indicator: "Muncul",
                    ),
                    ReportItem(
                      title: "Snack",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                      indicator: "Muncul",
                    ),
                    ReportItem(
                      title: "Kegiatan Inklusi",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                      indicator: "Muncul",
                    ),
                    ReportItem(
                      title: "Catatan",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                      indicator: "Muncul",
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
