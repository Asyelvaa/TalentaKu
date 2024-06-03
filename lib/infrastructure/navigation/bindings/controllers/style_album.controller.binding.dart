import 'package:get/get.dart';

import '../../../../presentation/album_page/controllers/style_album.controller.dart';

class StyleAlbumControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StyleAlbumController>(
      () => StyleAlbumController(),
    );
  }
}
