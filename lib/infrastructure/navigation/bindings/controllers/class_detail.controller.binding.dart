import 'package:get/get.dart';

import '../../../../presentation/class_detail/controllers/class_detail.controller.dart';

class ClassDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassDetailController>(
      () => ClassDetailController(),
    );
  }
}
