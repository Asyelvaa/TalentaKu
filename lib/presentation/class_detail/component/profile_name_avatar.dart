import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/class_detail/controllers/class_detail.controller.dart';


class ProfileNameAvatar extends GetView<ClassDetailController> {
  final String name;
  final String profile;
  const ProfileNameAvatar({
    super.key,
    required this.name,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: widthScreen * 0.2,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(profile),
          ),
          Text(
            name,
            style: AppTextStyle.tsLittle.copyWith(color: AppColor.white), 
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
