import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageController extends GetxController {
  //TODO: Implement HomeController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> showBottomSheet() async {
    Get.bottomSheet(
        backgroundColor: AppColor.background,
        isScrollControlled: true,
        Container(
          width: double.infinity,
          height: Get.height * 0.6,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "Terapi Wicara",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       // borderRadius: BorderRadius.circular(10),
              //       image: DecorationImage(
              //           image: AssetImage("assets/images/wacara.png"),
              //           fit: BoxFit.fill)),
              // ),
              SizedBox(
                height: 15,
              ),
              Image.asset("assets/images/wacara.png"),
              SizedBox(
                height: 20,
              ),
              Text(
                "This subheader is pinned to the top so you can adjust the symbol height as necessary. Bottom padding should be 16px.This subheader is pinned to the top so you can adjust the symbol height as necessary. Bottom padding should be 16px.",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.normal, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),

              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.blue300,
                  ),
                  child: Text("kembali"),
                ),
              )
            ],
          ),
        ));
  }
}
