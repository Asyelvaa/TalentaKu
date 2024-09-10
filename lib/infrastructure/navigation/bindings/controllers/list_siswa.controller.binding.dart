import 'package:get/get.dart';

import '../../../../presentation/list_siswa/controllers/list_siswa.controller.dart';

class ListSiswaControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListSiswaController>(
      () => ListSiswaController(),
    );
  }
}
