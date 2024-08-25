import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../infrastructure/theme/theme.dart';
import '../login_page/controllers/login.controller.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final username = GetStorage().read('dataUser')['name'];
    print(username);
    return AppBar(
      backgroundColor: AppColor.background,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthScreen * 0.02,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(AppImage.logoTalentaku, scale: 12),
            SizedBox(width: widthScreen * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${username}',
                  style: AppTextStyle.tsTitleBold(AppColor.black),
                ),
                Text(
                  'Semangat buat hari ini yaa..',
                  style: AppTextStyle.tsSmallRegular(AppColor.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
