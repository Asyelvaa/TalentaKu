import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/grade_page/controllers/grade.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ClassComponent extends GetView<GradeController> {
  String title;
  String tahun;
  String image;
  ClassComponent({
    super.key,
    required this.image,
    required this.title,
    required this.tahun,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: Get.width ,
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColor.blue100),
      child: Row(
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
                  tahun,
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
          Image.asset("assets/images/abc.png"),
        ],
      ),
    );
  }
}
