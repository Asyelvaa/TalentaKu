import 'package:get/get.dart';

import '../../../../presentation/submission_page/controllers/submission_page.controller.dart';

class SubmissionPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmissionPageController>(
      () => SubmissionPageController(),
    );
  }
}
