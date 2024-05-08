import 'package:get/get.dart';

import '../../../../presentation/grade_page/controllers/grade.controller.dart';

class GradeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GradeController>(
      () => GradeController(),
    );
  }
}
