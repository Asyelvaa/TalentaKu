import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/custom_textFormField.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                "assets/images/talentaku.png",
                scale: 4,
                fit: BoxFit.fill,
              ),
              defaultHeightSpace,
              Container(
                width: widthScreen * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Column(
                          children: [
                            CustomTextFormField(
                              loginController: controller.emailController,
                              labelText: "Masukkan email anda",
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              loginController: controller.passwordController,
                              isPassword: true,
                              labelText: "Masukkan pin anda",
                            ),
                            defaultHeightSpace,
                            Obx(() {
                              return SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 50,
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.login,
                                  color: AppColor.blue600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                  child: controller.isLoading.value
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColor.blue200),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Lanjut",
                                              style: AppTextStyle.tsTitle.copyWith(
                                                  color: Colors.white,
                                              )
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(
                                              size: 20,
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                ),
                              );
                            }),
                          ],
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


