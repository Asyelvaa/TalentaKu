import 'package:get/get.dart';

import '../../../../presentation/report_list_user_page/controllers/report_list_user_page.controller.dart';

class ReportListUserPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportListUserPageController>(
      () => ReportListUserPageController(),
    );
  }
}
