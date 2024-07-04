import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../login_pick_image/controllers/login_pick_image.controller.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final PickimageController controller = Get.put(PickimageController());

    return Obx(() {
      return Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: controller.image.value != null
                ? FileImage(controller.image.value!)
                : AssetImage('assets/default_profile.png') as ImageProvider,
            foregroundColor: AppColor.blue400,
          ),
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
    });
  }
}
