import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/profile_name_avatar.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../controllers/class_detail.controller.dart';

class HeaderClass extends StatelessWidget {
  const HeaderClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());

    return Container(
      height: 100,
      width: widthScreen,
      decoration: BoxDecoration(
          color: AppColor.blue600,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.classMembers.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final profile = controller.classMembers[index];
              return ProfileNameAvatar(
                name: profile.name,
                profile: profile.photo,
              );
            },
          );
        }),
      ),
    );
  }
}
