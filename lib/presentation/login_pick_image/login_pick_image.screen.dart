import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/login_pick_image.controller.dart';

class PickImageScreen extends GetView<PickimageController> {
  PickImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue200,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/talentaku.png',
                scale: 4,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16),
              Container(
                width: Get.width * 0.8,
                // height: heightScreen * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: heightScreen * 0.05,
                      horizontal: widthScreen * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Selamat datang',
                          style: AppTextStyle.tsTitleBold(AppColor.black)),
                      Text('Anda masuk sebagai...',
                          style: AppTextStyle.tsBodyRegular(AppColor.black)),
                      spaceHeightLarge,
                      Stack(
                        children: [
                          Obx(
                            () {
                              return controller.image.value != null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          FileImage(controller.image.value!),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundColor: AppColor.blue600,
                                      child: Text(
                                        getInitials('${controller.username}'),
                                          // controller.username.split(' ')[0][0],
                                          style: AppTextStyle.tsBigTitleBold(
                                              AppColor.white)),
                                    );
                            },
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
                                  border: Border.all(
                                      color: AppColor.white, width: 1),
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
                      ),
                      spaceHeightLarge,
                      Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColor.white,
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: AppColor.blue700,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(controller.username,
                              style: AppTextStyle.tsBodyBold(AppColor.black)),
                        ),
                      ),
                      spaceHeightSmall,
                      Obx(() {
                        return SizedBox(
                          width: Get.width,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    if (controller.image.value != null) {
                                      controller.uploadImageToApi();
                                    } else {
                                      print("No image selected");
                                      Get.offNamed(Routes.NAVBAR);
                                    }
                                  },
                            color: AppColor.blue600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: AppColor.blue200,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Lanjut",
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        size: 20,
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
String getInitials(String name) {
  List<String> nameParts = name.split(' ');
  if (nameParts.length == 1) {
    return nameParts[0].substring(0, 2).toUpperCase();
  } else {
    return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
  }
}
