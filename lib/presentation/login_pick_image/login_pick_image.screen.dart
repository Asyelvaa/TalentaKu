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
          width: widthScreen,
          height: heightScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/talentaku.png',
                scale: 4,
                fit: BoxFit.fill,
              ),
              defaultHeightSpace,
              Container(
                width: widthScreen * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat datang',
                        style: AppTextStyle.tsTitle
                      ),
                      Text(
                        'Semangat buat hari ini ya...',
                        style: AppTextStyle.tsNormal
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Stack(
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
                                          controller.username
                                              .substring(2)
                                              .toUpperCase(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
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
                      ),
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
                          child: Text(
                            controller.username,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Obx(() {
                        return controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: AppColor.white,
                              )
                            : SizedBox(
                                width: Get.width,
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 50,
                                  onPressed: () {
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Lanjut",
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
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
