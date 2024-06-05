import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'controllers/pickimage.controller.dart';

class PickImageScreen extends GetView<PickimageController> {
  const PickImageScreen({Key? key}) : super(key: key);

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
                                        radius: 70,
                                      );
                              },
                            ),
                            Positioned(
                              child: IconButton(
                                iconSize: 20,
                                color: AppColor.black,
                                onPressed: () =>
                                    controller.pickImage(ImageSource.gallery),
                                icon: Icon(Icons.add_a_photo),
                              ),
                              bottom: -10,
                              left: 80,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 257,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: () => controller.uploadImageToApi(),
                            color: AppColor.blue600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
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
