import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../home/controllers/home.controller.dart';

class HomeContent extends GetView<HomePageController> {
  final String? title;
  final String? txtButton;
  final void Function()? onTap;
  const HomeContent({
    Key? key,
    this.title,
    this.txtButton,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.blue600, width: 2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 6),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.blue50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Check It",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
