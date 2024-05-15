import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail/component/profile_name_avatar.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class HeaderClass extends StatelessWidget {
  const HeaderClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> _profileData = [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
          color: AppColor.blue600,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: Get.width,
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _profileData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final profile = _profileData[index];
                  return ProfileNameAvatar(
                    name: profile['name'],
                    profile: profile['profileImageUrl'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
