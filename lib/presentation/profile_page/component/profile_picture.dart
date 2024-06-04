import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/profile_page/model/user_model.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   // final UserModel user = mockUserList[0];

    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          //backgroundImage: AssetImage(user.photoProfile), 
          foregroundColor: AppColor.blue400,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.blue600,
                border: Border.all(color: AppColor.white, width: 1)),
            child: Icon(
              Iconsax.camera5,
              size: 20,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }
}
