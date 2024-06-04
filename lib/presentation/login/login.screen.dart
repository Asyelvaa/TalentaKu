import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inisialisasi LoginController
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColor.blue200,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/images/talentaku.png",
                height: 110,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              Container(
                width: 317,
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.blue50.withOpacity(0.7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 80,
                        bottom: 10,
                      ),
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
                      padding: const EdgeInsets.only(left: 70, bottom: 20),
                      child: Text(
                        'Semangat buat hari ini ya...',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: loginController.emailController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.blue500),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.blue500),
                              ),
                              labelText: "Masukan nomer induk anda",
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: loginController.passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.blue500),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.blue400),
                              ),
                              labelText: "Masukan pin anda",
                            ),
                          ),
                          const SizedBox(height: 30),
                          Obx(() {
                            return SizedBox(
                              width: double.infinity,
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 50,
                                onPressed: loginController.isLoading.value
                                    ? null
                                    : loginController.login,
                                color: AppColor.blue600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                child: loginController.isLoading.value
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
