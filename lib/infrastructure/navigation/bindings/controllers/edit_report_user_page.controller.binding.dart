import 'package:get/get.dart';

import '../../../../presentation/edit__report_user_page/controllers/edit_report_user_page.controller.dart';

class EditReportUserPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditReportUserPageController>(
      () => EditReportUserPageController(),
    );
  }
}
