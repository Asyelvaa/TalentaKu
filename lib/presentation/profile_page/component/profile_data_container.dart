import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfileDataContainer extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? dataUser;
  const ProfileDataContainer({
    super.key,
    required this.title,
    this.dataUser,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      width: widthScreen * 0.4,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: AppColor.blue500),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Icon(
            //   icon,
            //   size: 20,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        AppTextStyle.tsLittle.copyWith(color: AppColor.black)),
                Text(
                  dataUser ?? "Data User",
                  style: AppTextStyle.tsLittle,
                  selectionColor: AppColor.black,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
