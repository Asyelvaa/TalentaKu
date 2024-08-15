import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/text_background.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/custom_textFormField.dart';
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
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Selamat datang',
                          style: AppTextStyle.tsTitleBold(AppColor.black)),
                      Text('Semangat buat hari ini ya...',
                          style: AppTextStyle.tsBodyRegular(AppColor.black)),
                      spaceHeightLarge,
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                        child: Column(
                          children: [
                            TextWithBackground(
                                colorBackground: AppColor.blue50,
                                text:
                                    'Masukkan akun yang diberikan dari sekolah'),
                            // Text('Masukkan akun yang diberikan oleh Gurumu',
                            // style: AppTextStyle.tsSmallRegular(AppColor.blue800),),
                            spaceHeightSmall,
                            CustomTextFormField(
                              loginController: controller.emailController,
                              labelText: "Masukkan email anda",
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              loginController: controller.passwordController,
                              isPassword: true,
                              labelText: "Masukkan password anda",
                            ),
                          ],
                        ),
                      ),
                      spaceHeightLarge,
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
                              borderRadius: defaultBorderRadius,
                            ),
                            elevation: 0,
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.blue200),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Lanjut",
                                          style: AppTextStyle.tsTitle.copyWith(
                                            color: Colors.white,
                                          )),
                                      defaultWidthtSpace,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
