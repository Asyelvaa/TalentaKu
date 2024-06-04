import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';

class ClassItem extends StatelessWidget {
  String title;
  String description;
  String image;
  ClassItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.CLASS_DETAIL), 
      child: Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(20),
        width: widthScreen,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: AppColor.blue100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.tsNormal,
                ),
                Text(
                  description,
                  style: AppTextStyle.tsLittle,
                ),
                
              ],
            ),
            Image.asset("assets/images/abc.png", scale: 2,),
          ],
        ),
      ),
    );
  }
}
