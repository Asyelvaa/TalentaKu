import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../common_widget/back_appbar.dart';
import 'controllers/report_list_page.controller.dart';

class ReportListPageScreen extends GetView<ReportListPageController> {
  const ReportListPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BackAppbar(
          titleAppbar: 'Laporan Pembelajaran',
        ),
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await controller.fetchDataReport();

          refreshController.refreshCompleted();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.filteredReportData.isEmpty) {
            return Center(
              child: Text(
                'Belum ada laporan harian.',
                style: AppTextStyle.tsNormal,
              ),
            );
          }

          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: CustomDropdown<String?>(
                  hintText: 'Pilih Semester',
                  items: ['Semester 1', 'Semester 2'],
                  controller: controller.dropdownController,
                  onChanged: (value) {
                    controller.selectedSemester.value =
                        value == 'Semester 1' ? '1' : '2';
                    controller.filterReportData();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("data"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                height: heightScreen * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.blue400,
                ),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredReportData.length,
                    itemBuilder: (context, index) {
                      var report = controller.filteredReportData[index];
                      DateTime createdDate = DateTime.parse(report['created']);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            '${DateFormat('dd MMMM yyyy').format(createdDate)}',
                            style: AppTextStyle.tsTitle
                                .copyWith(color: AppColor.white),
                          ),
                          onTap: () {
                            print(report);
                            Get.toNamed(Routes.DAILY_REPORT,
                                arguments: [report]);
                          },
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
