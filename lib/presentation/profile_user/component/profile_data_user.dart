import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final String? description;
  const ProfileList({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: defaultBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.tsSmallRegular(AppColor.black),
          ),
          Text(
            description ?? " Data User ",
            style: AppTextStyle.tsBodyBold(AppColor.black),
          ),
        ],
      ),
    );
  }
}
