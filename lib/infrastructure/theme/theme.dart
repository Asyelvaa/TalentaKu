//COLOR
import "package:flutter/material.dart";
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const Color blue50 = Color.fromRGBO(242, 244, 255, 1);
  static const Color blue100 = Color.fromRGBO(213, 221, 255, 1);
  static const Color blue200 = Color.fromRGBO(193, 205, 255, 1);
  static const Color blue300 = Color.fromRGBO(165, 182, 255, 1);
  static const Color blue400 = Color.fromRGBO(148, 168, 255, 1);
  static const Color blue500 = Color.fromRGBO(121, 146, 255, 1);
  static const Color blue600 = Color.fromRGBO(110, 133, 232, 1);
  static const Color blue700 = Color.fromRGBO(86, 104, 181, 1);
  static const Color blue800 = Color.fromRGBO(67, 80, 140, 1);
  static const Color blue900 = Color.fromRGBO(51, 61, 107, 1);
  static const Color black = Color(0xff353535);
  static const Color grey = Color(0xffF4F4F4);
  static const Color white = Color(0xffFEFEFE);
  static const Color background = Color(0xffFAFAFA);
  static const Color red = Color(0xffF8475E);
}

//FONT STYLES INITIAL

figmaFontsize(int fontSize) {
  return fontSize * 1.2;
}

SizedBox defaultHeightSpace = SizedBox(height: 24,);
SizedBox spaceHeightLarge = SizedBox(height: 24);
SizedBox spaceHeightNormal = SizedBox(height: 20);
SizedBox spaceHeightSmall = SizedBox(height: 12);
SizedBox spaceHeightExtraSmall = SizedBox(height: 8);

SizedBox defaultWidthtSpace = SizedBox(width: 12,);
BorderRadius defaultBorderRadius = BorderRadius.circular(12);

final widthScreen = Get.mediaQuery.size.width;
final heightScreen = Get.mediaQuery.size.height;

class AppTextStyle {
   static TextStyle tsBigTitleBold(Color color) {
    return GoogleFonts.manrope(
    fontSize: figmaFontsize(20),
    fontWeight: FontWeight.bold,
    color: color,
  );}
  static TextStyle tsTitleBold(Color color) {
    return GoogleFonts.manrope(
    fontSize: figmaFontsize(16),
    fontWeight: FontWeight.bold,
    color: color,
  );}
  static TextStyle tsBodyRegular(Color color) {
    return GoogleFonts.manrope(
    fontSize: figmaFontsize(14),
    fontWeight: FontWeight.normal,
    color: color,
  );}
  static TextStyle tsBodyBold(Color color) {
    return GoogleFonts.manrope(
    fontSize: figmaFontsize(14),
    fontWeight: FontWeight.bold,
    color: color,
  );}
  static TextStyle tsSmallRegular(Color color) {
    return GoogleFonts.manrope(
    fontSize: figmaFontsize(12),
    fontWeight: FontWeight.normal,
    color: color,
  );}
  static TextStyle tsSmallBold(Color color) {
    return GoogleFonts.manrope(
    fontSize: figmaFontsize(12),
    fontWeight: FontWeight.bold,
    color: color,
  );}

  static TextStyle tsTitle = GoogleFonts.manrope(
    fontSize: figmaFontsize(16),
    fontWeight: FontWeight.bold,
  );
  static TextStyle tsNormal = GoogleFonts.manrope(
    fontSize: figmaFontsize(12),
    fontWeight: FontWeight.w500,
  );
  static TextStyle tsLittle = GoogleFonts.manrope(
    fontSize: figmaFontsize(10),
    color: AppColor.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle tsTextContainer = GoogleFonts.manrope(
    fontSize: figmaFontsize(16),
    fontWeight: FontWeight.w800,
    color: AppColor.black
  );

}

class AppImage {
  static const String logoTalentaku = 'assets/images/logo_talentaku.png';

}
