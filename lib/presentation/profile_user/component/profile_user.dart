import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/profile_page/controllers/profile_page.controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../login_pick_image/controllers/login_pick_image.controller.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final PickimageController controller = Get.put(PickimageController());
    // final ProfilePageController userController = Get.put(ProfilePageController());

    return Stack(
      children: [
        Obx(() {
          return controller.image.value != null
              ? CircleAvatar(
                  radius: 60,
                  // backgroundImage:  NetworkImage('https://talentaku.site/image/profile/' + userController.currentUser.value.photo!),
                  backgroundImage: FileImage(controller.image.value!))
              : CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColor.blue600,
                  child: Text(controller.username.substring(2).toUpperCase(),
                      style: AppTextStyle.tsSmallBold(AppColor.white)));
        }),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              controller.pickImage(ImageSource.gallery);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.blue600,
                border: Border.all(color: AppColor.white, width: 1),
              ),
              child: Icon(
                Iconsax.camera5,
                size: 20,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
