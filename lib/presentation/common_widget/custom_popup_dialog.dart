import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';

class CustomPopupDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  CustomPopupDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: widthScreen * 0.8, 
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColor.blue100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spaceHeightExtraSmall,
                  Text(
                    title,
                    style: AppTextStyle.tsTitleBold(AppColor.black),
                  ),
                  spaceHeightExtraSmall,
                  Text(
                    content,
                    style: AppTextStyle.tsBodyRegular(AppColor.black),
                    textAlign: TextAlign.center,
                  ),
                  spaceHeightNormal,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: actions,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            child: CircleAvatar(
              radius: 40, 
              backgroundColor: AppColor.blue100,
              child: Image.asset(
                AppImage.logoTalentaku,
                scale: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomPopupDialog(String title, String content, List<Widget> actions) {
  Get.dialog(
    CustomPopupDialog(
      title: title,
      content: content,
      actions: actions,
    ),
  );
}