import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.red,
          backgroundImage: AssetImage('assets/images/profilw.png'),
        ),
        Positioned(
          bottom: 15,
          right: 5,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.blue600,
                border: Border.all(color: Colors.white, width: 1)),
            child: Icon(
              Iconsax.edit_25,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }
}