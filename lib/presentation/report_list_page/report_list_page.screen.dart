import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common_widget/back_appbar.dart';
import 'controllers/report_list_page.controller.dart';

class ReportListPageScreen extends GetView<ReportListPageController> {
  const ReportListPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BackAppbar(
          titleAppbar: 'Laporan Pembelajaran',
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.reportData.isEmpty) {
          return Center(
              child: Text(
            'Belum ada laporan harian.',
            style: AppTextStyle.tsNormal,
          ));
        }

        return ListView.builder(
          itemCount: controller.reportData.length,
          itemBuilder: (context, index) {
            var report = controller.reportData[index];
            DateTime createdDate = DateTime.parse(report['created']);
            return ListTile(
              title: Text(
                'Laporan Harian ${DateFormat('dd MMMM yyyy').format(createdDate)}',
                style: AppTextStyle.tsNormal,
              ),
              onTap: () {
                Get.toNamed(Routes.DAILY_REPORT, arguments: [report]);
              },
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            );
          },
        );
      }),
    );
  }
}
