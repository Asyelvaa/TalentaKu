import 'package:get/get.dart';

import '../../../../presentation/edit_post_page/controllers/add_edit_post.controller.dart';

class AddEditPostControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditPostController>(
      () => AddEditPostController(),
    );
  }
}
