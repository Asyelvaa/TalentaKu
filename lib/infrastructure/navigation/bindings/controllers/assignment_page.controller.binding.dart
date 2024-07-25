import 'package:get/get.dart';

import '../../../../presentation/assignment_page/controllers/assignment_page.controller.dart';

class AssignmentPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignmentPageController>(
      () => AssignmentPageController(),
    );
  }
}
