import 'package:get/get.dart';

import '../../../../presentation/laporan_harian/controllers/laporan_harian.controller.dart';

class LaporanHarianControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanHarianController>(
      () => LaporanHarianController(),
    );
  }
}
