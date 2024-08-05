import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import '../controllers/class_detail.controller.dart';

class ProfileNameAvatar extends GetView<ClassDetailController> {
  final String name;
  final String? profile;

  const ProfileNameAvatar({
    Key? key,
    required this.name,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.blue100,
            backgroundImage: (profile != null && profile!.isNotEmpty)
                ? NetworkImage(profile!)
                : null,
            child: (profile == null || profile!.isEmpty)
                ? Text(
                    name.substring(0, 2).toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColor.black,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: AppTextStyle.tsLittle.copyWith(color: AppColor.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
