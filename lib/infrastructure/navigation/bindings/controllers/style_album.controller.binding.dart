import 'package:get/get.dart';

import '../../../../presentation/style_album/controllers/style_album.controller.dart';

class StyleAlbumControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StyleAlbumController>(
      () => StyleAlbumController(),
    );
  }
}
