import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../common_widget/back_appbar.dart';
import '../edit__report_user_page/edit_report_user_page.screen.dart';
import 'controllers/report_list_user_page.controller.dart';

class ReportListUserPageScreen extends GetView<ReportListUserPageController> {
  const ReportListUserPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = RefreshController(initialRefresh: false);
    final Rx<DateTime?> selectedDate = Rx<DateTime?>(null); 

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BackAppbar(
          titleAppbar: 'Laporan Pembelajaran',
        ),
      ),
      body: Column(
        children: [
          // Date Picker Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    selectedDate.value = pickedDate;
                  }
                },
                child: Text(
                  selectedDate.value != null
                      ? 'Filter: ${DateFormat('dd MMM yyyy').format(selectedDate.value!)}'
                      : 'Pilih Tanggal Laporan',
                  style: AppTextStyle.tsBodyRegular(AppColor.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue50,
                  elevation: 0
                ),
              ),
              // Reset Filter Button
              TextButton(
                onPressed: () {
                  selectedDate.value = null; // Reset the selected date
                },
                child: Text(
                'Reset Filter',
                style: AppTextStyle.tsBodyRegular(AppColor.black),
              ),
              
              )],
          ),
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

                // Filter and sort report data by the selected date
                var filteredReportData = controller.reportData.where((report) {
                  DateTime reportDate = DateTime.parse(report['created']);
                  return selectedDate.value == null ||
                      DateFormat('yyyy-MM-dd').format(reportDate) ==
                          DateFormat('yyyy-MM-dd').format(selectedDate.value!);
                }).toList();

                filteredReportData.sort((a, b) {
                  DateTime dateA = DateTime.parse(a['created']);
                  DateTime dateB = DateTime.parse(b['created']);
                  return dateB.compareTo(dateA); // Sort by descending date
                });

                if (filteredReportData.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada laporan untuk tanggal yang dipilih.',
                      style: AppTextStyle.tsNormal,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                    itemCount: filteredReportData.length,
                    itemBuilder: (context, index) {
                      var report = filteredReportData[index];
                      DateTime createdDate = DateTime.parse(report['created']);
                      return ListTile(
                        title: Text(
                          DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                              .format(createdDate),
                          style: AppTextStyle.tsBodyRegular(AppColor.black),
                        ),
                        onTap: () async {
                          // Get.to(() => EditReportUserPageScreen(),
                          // arguments: {
                          //   'reportId': report['id'].toString()
                          // }
                          // );
                          await Get.to( () =>
                           EditReportUserPageScreen(), arguments: ['edit', report])?.then((value) {
                            if (value == 'success') {
                              controller.fetchUserReport();
                            }
                          });
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
