import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfileList extends StatelessWidget {
  final String Title;
  final String? Description;
  const ProfileList({
    super.key,
    required this.Title,
    this.Description,
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
        borderRadius: defaultBorderRadius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              Title,
              style: AppTextStyle.tsSmallRegular(AppColor.black),
            ),
          ),
          Flexible(
            child: Text(
              Description ?? " Data User ",
              style: AppTextStyle.tsBodyBold(AppColor.black),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
