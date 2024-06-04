import 'package:get/get.dart';

import '../../../../presentation/login_pick_image/controllers/login_pick_image.controller.dart';

class PickimageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickimageController>(
      () => PickimageController(),
    );
  }
}
