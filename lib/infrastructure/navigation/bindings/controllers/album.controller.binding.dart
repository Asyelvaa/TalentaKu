import 'package:get/get.dart';

import '../../../../presentation/album_page/controllers/style_album.controller.dart';

class AlbumControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumController>(
      () => AlbumController(),
    );
  }
}
