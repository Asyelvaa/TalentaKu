import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

import '../common_widget/back_appbar.dart';
import 'controllers/report_list_user_page.controller.dart';

class ReportListUserPageScreen extends GetView<ReportListUserPageController> {
  const ReportListUserPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);
    final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
    final RxString selectedMonth = ''.obs;

    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BackAppbar(
            titleAppbar: 'Laporan Pembelajaran',
          ),
        ),
        body: Column(children: [
          // Date Picker and Dropdown Button

          Expanded(
              child: SmartRefresher(
                  controller: refreshController,
                  onRefresh: () async {
                    await controller.fetchUserReport();
                    refreshController.refreshCompleted();
                  },
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.reportData.isEmpty) {
                      return Center(
                        child: Text(
                          'Belum ada laporan harian.',
                          style: AppTextStyle.tsNormal,
                        ),
                      );
                    }
                    final List<dynamic> allReports = controller
                        .filteredReportData
                        .expand((monthData) => monthData['reports'])
                        .toList();

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.0),
                              CustomDropdown<String?>(
                                hintText: 'Pilih Bulan',
                                items: [
                                  'September 2024',
                                  'October 2024',
                                  'November 2024'
                                ],
                                controller: controller.dropdownMonthController,
                                onChanged: (value) {
                                  controller.onMonthChanged(value);
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Ada ${allReports.length} laporan",
                              style: AppTextStyle.tsNormal,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: allReports.length,
                            itemBuilder: (context, index) {
                              var report = allReports[index];
                              print(allReports.length);

                              DateTime createdDate =
                                  DateTime.parse(report['created']);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    '${DateFormat('dd MMMM yyyy').format(createdDate)}',
                                    style: AppTextStyle.tsBodyRegular(
                                        AppColor.black),
                                  ),
                                  onTap: () async {
                                    await Get.toNamed(
                                            Routes.EDIT_REPORT_USER_PAGE,
                                            arguments: ['edit', report])
                                        ?.then((value) {
                                      if (value == 'success') {
                                        controller.fetchUserReport();
                                      }
                                    });
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
                      ],
                    );
                  })))
        ]));
  }
}
