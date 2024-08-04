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
      padding: EdgeInsets.all(10),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.blue300, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.tsNormal,
          ),
          Text(
            description ?? "Data User",
            style: AppTextStyle.tsNormal,
          ),
        ],
      ),
    );
  }
}
