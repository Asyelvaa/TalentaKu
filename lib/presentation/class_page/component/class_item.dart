import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/models/class_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../controllers/class_page.controller.dart';

class ClassItem extends GetView<ClassController> {

  ClassItem({Key? key, }) : super(key: key);
  @override

  Widget build(BuildContext context) { 
     return Obx(() {
      final RxList<GradeModel> classItems = controller.gradesList; 
      return ListView.builder(
      itemCount: classItems.length,
      itemBuilder: (context, index) {
        final GradeModel classItem = classItems[index];
        return InkWell(
          onTap: () => Get.toNamed(
              Routes.CLASS_DETAIL,
              arguments: classItem,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: widthScreen,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColor.blue200,
                width: 1,
              ),
              // color: classItem.isActive ? AppColor.blue200 : Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classItem.name,
                      style: AppTextStyle.tsNormal,
                    ),
                    Text(
                      classItem.desc,
                      style: AppTextStyle.tsLittle,
                    ),
                  //   Text(
                  //     classItem.isActive ? '' : 'Archived Class',
                  //     style: AppTextStyle.tsLittle,
                  //   )
                  ],
                ),
                Image.asset(
                  "assets/images/abc.png",
                  scale: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
     });
  }
}
