import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/annoucement_component.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/informasi_siswa.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/informasi_teacher.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/materi_tugas/assignment_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';
import '../materi_tugas/assignment_list_student.dart';
import '../materi_tugas/assignment_list_teacher.dart';

class ContentBeranda extends GetView<ClassDetailController> {
  const ContentBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColor.blue200,));
        } else if (controller.userRole.any(
            (role) => role.contains('Murid KB') || role.contains('Murid SD'))) {
          return InformasiSiswa();
        } else if (controller.userRole.any(
            (role) => role.contains('Guru KB') || role.contains('Guru SD'))) {
          return InformasiTeacher();
        } else {
          return Text(controller.userRole.toString());
        }
      }),
    );
  }
}
