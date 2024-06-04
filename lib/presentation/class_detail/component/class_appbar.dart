import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';


class ClassAppbar extends StatelessWidget {
  final String titleAppbar;
  const ClassAppbar({
    super.key,
    required this.titleAppbar
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
      icon: Icon(Icons.arrow_back_rounded, color: AppColor.white),
      onPressed: () {
        Get.back();
      },
      ),
      title: Text( titleAppbar, style: AppTextStyle.tsTitle.copyWith(color: AppColor.white)),
      backgroundColor: AppColor.blue600,
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert_rounded, color: AppColor.white),
          onPressed: () {
          },
        ),
      ],
    );
  }
}