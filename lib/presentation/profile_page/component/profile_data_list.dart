import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: EdgeInsets.all(10),
      width: Get.width,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColor.blue300, width: 2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              Title,
            style:
                GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          Text(
            Description ?? " Data User ",
            style:
                GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
