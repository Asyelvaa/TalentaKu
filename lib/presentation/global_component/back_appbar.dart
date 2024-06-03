import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';

class BackAppbar extends StatelessWidget {
  final String titleAppbar;
  const BackAppbar({
    super.key,
    required this.titleAppbar
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
      icon: Icon(Icons.arrow_back_rounded, color: AppColor.blue600),
      onPressed: () {
        Get.back();
      },
      ),
      title: Text( titleAppbar, style: AppTextStyle.tsTitle),
      backgroundColor: AppColor.background,
    );
  }
}