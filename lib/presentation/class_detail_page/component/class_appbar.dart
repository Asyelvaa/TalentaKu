import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/edit_class_form.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

import '../../../domain/models/class_model.dart';
import '../../../infrastructure/theme/theme.dart';


class ClassAppbar extends GetView<ClassDetailController> {
  final String titleAppbar;
  final Map<String, dynamic> grade;
  const ClassAppbar({
    super.key,
    required this.titleAppbar,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
      icon: Icon(Icons.arrow_back_rounded, color: AppColor.white),
      onPressed: () {
        Get.back();
      },
      ),
      title: Text( titleAppbar, style: AppTextStyle.tsTitleBold(AppColor.white)),
      backgroundColor: AppColor.blue600,
      actions: [
        PopupMenuButton<int>(
          icon: Icon(Icons.more_vert_rounded, color: AppColor.white),
          onSelected: (value) {
            switch (value) {
              case 0 : Get.toNamed('/student-report-form'); break;
              case 1 : 
              Get.bottomSheet(
                EditClassBottomSheet(),
                isScrollControlled: true,
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Text('Buat Laporan Harian'),
            ),
            PopupMenuItem(
              value: 1,
              child: Text('Edit Kelas'),
            ),            
          ]
        )
      ],
    );
  }
}