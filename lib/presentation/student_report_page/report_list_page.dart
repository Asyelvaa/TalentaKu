import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import 'controllers/daily_report.controller.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DailyReportController());
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Laporan Pembelajaran')),
        body: ListTile(
          title: Text('Laporan Harian 1'),
          onTap: () {
            Get.toNamed(Routes.DAILY_REPORT, arguments: []);
          },
          trailing: Icon(Icons.arrow_forward_ios),
        )
        );
  }
}
