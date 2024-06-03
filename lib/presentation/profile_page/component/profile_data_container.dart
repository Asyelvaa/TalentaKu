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
      height: 70,
      width: widthScreen * 0.4,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColor.blue400),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 5, left: 15), child: Icon(icon)),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, right: 10),
                child: Text(title,
                    style: AppTextStyle.tsLittle.copyWith(color: Colors.grey)),
              ),
              Padding(
                  padding: EdgeInsets.only(),
                  child: Text(dataUser ?? "Data User",
                      style: AppTextStyle.tsNormal))
            ],
          ),
        ],
      ),
    );
  }
}
