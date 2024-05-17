import 'package:flutter_talentaku/presentation/daily_report/controllers/daily_report.controller.dart';
import 'package:get/get.dart';


class DailyReportControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyReportController>(
      () => DailyReportController(),
    );
  }
}
