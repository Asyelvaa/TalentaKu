import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfileDataContainer extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? dataUser;
  const ProfileDataContainer({
    super.key,
    required this.title,
    this.dataUser,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColor.blue400),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 5, left: 20),
              child: Icon(icon)),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Text(
                  title,
                  style:AppTextStyle.tsLittle.copyWith(color: Colors.grey)
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    dataUser ?? "Data User",
                    style: AppTextStyle.tsNormal
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}