import 'package:get/get.dart';

import '../../../../presentation/profile_user/controllers/profile_user.controller.dart';

class ProfileUserControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUserController>(
      () => ProfileUserController(),
    );
  }
}
