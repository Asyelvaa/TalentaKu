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
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(profile),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            name,
            style: AppTextStyle.tsNormal
          ),
        )
      ],
    );
  }
}
