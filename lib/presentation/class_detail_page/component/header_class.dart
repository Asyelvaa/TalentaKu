import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/profile_name_avatar.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class HeaderClass extends StatelessWidget {
  const HeaderClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> _profileData = [];
    _profileData = [
      {
        'name': 'Sekar Annisa',
        'profileImageUrl': 'assets/images/student.png',
      },
      {
        'name': 'Jane Smith',
        'profileImageUrl': 'assets/images/student.png',
      },
      {
        'name': 'John Doe',
        'profileImageUrl': 'assets/images/student.png',
      },
      {
        'name': 'Jane Doe',
        'profileImageUrl': 'assets/images/student.png',
      },
    ];
    return Container(
      height: 90,
      width: widthScreen,
      decoration: BoxDecoration(
          color: AppColor.blue600,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
    );
  }
}
