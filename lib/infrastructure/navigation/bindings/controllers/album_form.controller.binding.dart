import 'package:get/get.dart';

import '../../../../presentation/album_form_page/controllers/album_form.controller.dart';

class AlbumFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumFormController>(
      () => AlbumFormController(),
    );
  }
}
