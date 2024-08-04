import 'package:get/get.dart';

import '../../../../presentation/report_list_page/controllers/report_list_page.controller.dart';

class ReportListPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportListPageController>(
      () => ReportListPageController(),
    );
  }
}
