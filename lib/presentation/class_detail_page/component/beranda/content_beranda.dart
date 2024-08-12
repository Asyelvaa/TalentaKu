import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/assigment_list_guru.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/assigment_list_student_beranda.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/materi_tugas/assignment_list_teacher.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../common_widget/custom_button_icon.dart';

class ContentBeranda extends GetView<ClassDetailController> {
  const ContentBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(() {
        var roles = controller.currentUser.value.roles;
        if (roles != null && roles.any((role) => role.contains('Guru'))) {
          return AssigmentGuru();
        } else {
          return AssigmentBeranda();
        }
      }),
    );
  }
}
