import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/theme.dart';

class ClassButtonActionStudent extends StatelessWidget {
  const ClassButtonActionStudent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());
    return Expanded(
        child: GestureDetector(
      onTap: () {
        var classItemId = controller.classItem["id"].toString();
        Get.toNamed(Routes.REPORT_LIST_PAGE,
            arguments: {"gradeId": classItemId});
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
            height: heightScreen * 0.07,
            width: widthScreen,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColor.blue50, borderRadius: defaultBorderRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [                
                AutoSizeText(
                  'Laporan Pembelajaran',
                  style: AppTextStyle.tsBodyBold(AppColor.black),
                  minFontSize: 12,
                ),  
                SizedBox(width: 15),             
              ],
            )),
        Positioned(
            left: 20,
            top: -5,
            child: Image.asset(
              'assets/images/stiker_laporan.png',
              scale: 8,
            ))
      ]),
    ));
  }
}
