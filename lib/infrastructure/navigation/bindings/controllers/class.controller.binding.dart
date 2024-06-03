import 'package:get/get.dart';

import '../../../../presentation/grade_page/controllers/class_page.controller.dart';

class GradeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassController>(
      () => ClassController(),
    );
  }
}
