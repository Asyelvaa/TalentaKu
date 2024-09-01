import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:flutter_talentaku/presentation/profile_page/controllers/profile_page.controller.dart';
import 'package:get/get.dart';

class UpdatePassword extends GetView<ProfilePageController> {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.05, vertical: heightScreen * 0.05),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: defaultBorderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Adjust the shadow color and opacity
                  spreadRadius: 2, // How much the shadow spreads
                  blurRadius: 8, // Softness of the shadow
                  offset: Offset(0, 4), // Horizontal and vertical offset of the shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Update Password",
                  style: AppTextStyle.tsTitleBold(AppColor.black)
                ),
                SizedBox(height: heightScreen * 0.05),
                // Current Password Field
                TextFormField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password sekarang",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // New Password Field
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Sandi baru",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Confirm New Password Field
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Konfirmasi sandi baru",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.05),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentPassword =
                          currentPasswordController.text.trim();
                      final newPassword = newPasswordController.text.trim();
                      final confirmPassword =
                          confirmPasswordController.text.trim();
          
                      if (newPassword != confirmPassword) {
                        dialogError('Password baru tidak sesuai');
                        // Get.snackbar(
                        //   'Error',
                        //   'New passwords do not match.',
                        //   snackPosition: SnackPosition.BOTTOM,
                        // );
                        return;
                      }
          
                      try {
                        await controller.updatePassword(
                          currentPassword,
                          newPassword,
                          confirmPassword,
                        );
                      } catch (e) {
                        dialogError('Gagal memperbarui password');
                        print('Error: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.blue600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    child: Text(
                      "Ubah Kata Sandi",
                      style: AppTextStyle.tsNormal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void dialogSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColor.blue100,
      colorText: AppColor.black,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  void dialogError(String message) {
    Get.snackbar(
      'Gagal',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }