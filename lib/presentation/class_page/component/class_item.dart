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
        width: widthScreen,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: AppColor.blue100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
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
                  Spacer(),
                  Stack(
                    children: [
                      Container(
                        width: Get.width * 0.4,
                        height: 40,
                        child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(image),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Image.asset("assets/images/abc.png", scale: 1.5,),
          ],
        ),
      ),
    );
  }
}
