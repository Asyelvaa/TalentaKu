import 'package:get/get.dart';

import '../../../../presentation/AddEditPost/controllers/add_edit_post.controller.dart';

class AddEditPostControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditPostController>(
      () => AddEditPostController(),
    );
  }
}
