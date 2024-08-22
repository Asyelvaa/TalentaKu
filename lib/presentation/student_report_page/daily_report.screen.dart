import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/text_background.dart';
import 'component/media_display.dart';
import 'controllers/daily_report.controller.dart';
import 'component/report_item.dart';

class DailyReportScreen extends GetView<DailyReportController> {
  DailyReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(controller.singleReportData);
    return Scaffold(
      backgroundColor: AppColor.background,
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
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
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
                        title: "Kegiatan Awal Diahalaman",
                        data: controller
                            .singleReportData['kegiatan_awal_dihalaman'],
                        fieldName: 'kegiatan_awal_dihalaman',
                        fieldPoint: 'dihalaman_hasil',
                      ),
                      ReportItem(
                        title: "Kegiatan Awal Berdoa",
                        data:
                            controller.singleReportData['kegiatan_awal_berdoa'],
                        fieldName: 'kegiatan_awal_berdoa',
                        fieldPoint: 'berdoa_hasil',
                      ),
                      ReportItem(
                        title: "Kegiatan Inti Satu",
                        data: controller.singleReportData['kegiatan_inti_satu'],
                        fieldName: 'kegiatan_inti_satu',
                        fieldPoint: 'inti_satu_hasil',
                      ),
                      ReportItem(
                        title: "Kegiatan Inti Dua",
                        data: controller.singleReportData['kegiatan_inti_dua'],
                        fieldName: 'kegiatan_inti_dua',
                        fieldPoint: 'inti_dua_hasil',
                      ),
                      ReportItem(
                        title: "Kegiatan Inti Tiga",
                        data: controller.singleReportData['kegiatan_inti_tiga'],
                        fieldName: 'kegiatan_inti_tiga',
                        fieldPoint: 'inti_tiga_hasil',
                      ),
                      ReportItem(
                        title: "Snack",
                        data: controller.singleReportData['snack'],
                        fieldName: 'snack',
                        fieldPoint: 'none',
                      ),
                      ReportItem(
                        title: "Kegiatan Inklusi",
                        data: controller.singleReportData['inklusi'],
                        fieldName: 'inklusi',
                        fieldPoint: 'inklusi_hasil',
                      ),
                      ReportItem(
                        title: "Penutup",
                        data: controller.singleReportData['inklusi_penutup'],
                        fieldName: 'inklusi_penutup',
                        fieldPoint: 'inklusi_penutup_hasil',
                      ),
                      ReportItem(
                        title: "Doa",
                        data: controller.singleReportData['inklusi_doa'],
                        fieldName: 'inklusi_doa',
                        fieldPoint: 'inklusi_doa_hasil',
                      ),
                      ReportItem(
                        title: "Catatan",
                        data: controller.singleReportData['catatan'],
                        fieldName: 'catatan',
                        fieldPoint: 'none',
                      ),
                      SizedBox(height: 20),
                      MediaDisplay(media: controller.singleReportData['media']),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
