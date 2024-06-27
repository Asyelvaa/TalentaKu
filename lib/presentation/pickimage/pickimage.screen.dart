import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'controllers/pickimage.controller.dart';

class PickImageScreen extends GetView<PickimageController> {
  PickImageScreen({Key? key}) : super(key: key);

  final box = GetStorage();
  final String username = GetStorage().read('username');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue200,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/talentaku.png',
                height: 120,
                width: 150,
                fit: BoxFit.fill,
              ),
              Center(
                child: Container(
                  width: 317,
                  height: 440,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Selamat datang',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'Semangat buat hari ini ya...',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Obx(
                              () {
                                return controller.image.value != null
                                    ? CircleAvatar(
                                        radius: 70,
                                        backgroundImage:
                                            FileImage(controller.image!.value!),
                                      )
                                    : CircleAvatar(
                                        radius: 60,
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
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 257,
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
                              username,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 257,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: () => controller.uploadImageToApi(),
                            color: AppColor.blue600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            child: Row(
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
                                SizedBox(width: 5),
                                Icon(
                                  size: 20,
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
