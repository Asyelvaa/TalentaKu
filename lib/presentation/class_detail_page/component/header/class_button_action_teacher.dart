import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../infrastructure/theme/theme.dart';
import 'class_bottomsheet_action_teacher.dart';

class ClassButtonActionTeacher extends StatelessWidget {
  const ClassButtonActionTeacher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.bottomSheet(ClassBottomsheetActionTeacher());
          },
          child: Container(
            height: heightScreen * 0.07,
            padding: EdgeInsets.symmetric(
              horizontal: widthScreen * 0.04,
            ),
            decoration: BoxDecoration(
                color: AppColor.blue50, borderRadius: defaultBorderRadius),
            child: Icon(
              Iconsax.add,
              size: 30,
              color: AppColor.black,
            ),
          ),
        ),
        defaultWidthtSpace,
        Expanded(
            child: GestureDetector(
          onTap: () {
            controller.box
                .write('gradeId', controller.classItem["id"].toString());
            Get.toNamed('/list-siswa',
                arguments: {"gradeId": controller.classItem["id"].toString()});
            //  arguments: {
            //   "gradeId": controller.classItem["id"].toString()
            // });
          },
          child: Stack(clipBehavior: Clip.none, children: [
            Container(
                // height: heightScreen * 0.075,
                width: widthScreen,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColor.blue50, borderRadius: defaultBorderRadius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: widthScreen * 0.14,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Buat',
                            style: AppTextStyle.tsSmallRegular(AppColor.black),
                            minFontSize: 10,
                          ),
                          AutoSizeText(
                            'Laporan Pembelajaran',
                            style: AppTextStyle.tsBodyBold(AppColor.black),
                            minFontSize: 10,
                          )
                        ]),
                  ],
                )),
            Positioned(
                left: -5,
                bottom: 0,
                child: Image.asset(
                  'assets/images/stiker_laporan.png',
                  scale: 8,
                ))
          ]),
        ))
      ],
    );
  }
}
