import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/class_detail/controllers/class_detail.controller.dart';


class siswa extends GetView<ClassDetailController> {
  final String? name;
  final String? profile;
  const siswa({
    super.key,
    this.name,
    this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(profile!),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            name!,
            style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: AppColor.white),
          ),
        )
      ],
    );
  }
}
