import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/student_report_page/controllers/daily_report.controller.dart';
import 'package:get/get.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/student_report_page/component/report_item.dart';

import '../global_component/text_background.dart';

class DailyReportScreen extends GetView<DailyReportController> {
  DailyReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        backgroundColor: AppColor.blue600,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
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
                        SizedBox(
                          height: 5,
                        ),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (controller.reportData.isEmpty) {
                            return Center(
                                child: Text('tidak ada data yang ditampilkan'));
                          } else {
                            final data = controller.reportData['data'];
                            return Row(
                              children: [
                                TextWithBackground(
                                  colorBackground: AppColor.white,
                                  text: "Semester ${data['semester_id']}",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ReportItem(
                          title: "Kegiatan Awal",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                          indicator: "Muncul",
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
