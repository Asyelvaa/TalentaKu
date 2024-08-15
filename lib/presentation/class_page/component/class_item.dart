import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../controllers/class_page.controller.dart';

class ClassItem extends GetView<ClassController> {

  ClassItem({Key? key, }) : super(key: key);

  Widget build(BuildContext context) { 
    final activeClasses = controller.activeClasses;
    final inactiveClasses = controller.inactiveClasses;

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...activeClasses.map((classItem) => buildClassItem(context, classItem)).toList(),
        spaceHeightNormal,
        if (inactiveClasses.isNotEmpty)
          Text(
            'Arsip Kelas :',
            style: AppTextStyle.tsBodyBold(AppColor.black),
          ),
          spaceHeightExtraSmall,
        ...inactiveClasses.map((classItem) => buildClassItem(context, classItem)).toList(),
      ],
    );
  }

   Widget buildClassItem(BuildContext context, Map<String, dynamic> classItem) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.CLASS_DETAIL,
        arguments: classItem,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: classItem['is_active'] == 'true'
                  ? AppColor.blue100
                  : Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classItem['name'],
                      style: AppTextStyle.tsBodyBold(AppColor.black),
                    ),
                    Text(
                      classItem['desc'],
                      style: AppTextStyle.tsSmallRegular(AppColor.black),
                    ),                    
                  ],
                ),
                Image.asset(
                  "assets/images/abc.png",
                  scale: 1.5,
                ),
              ],
            ),
          ),
          spaceHeightExtraSmall
        ],
      ),
    );
  }
}