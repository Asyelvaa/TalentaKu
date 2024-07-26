import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/class_detail.controller.dart';


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
          Obx(
            () {
              return profile.isNotEmpty
              ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(profile)
              )
              : CircleAvatar( 
                  radius: 30,
                  backgroundColor: AppColor.blue100,
                  child: Text(
                   controller.classMembers
                          .firstWhere((student) => student.name == name)
                          .name
                          .substring(0, 2)
                          .toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColor.black
                  ),
                )                        
              );
            }),
          SizedBox(height: 4),
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
