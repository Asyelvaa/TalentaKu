import 'package:get/get.dart';

import '../../../../presentation/pickimage/controllers/pickimage.controller.dart';

class PickimageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickimageController>(
      () => PickimageController(),
    );
  }
}
