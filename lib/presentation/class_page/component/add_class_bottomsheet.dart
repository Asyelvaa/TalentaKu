import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_button_action_main.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_button_action_secondary.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../common_widget/custom_textFormField.dart';
import '../controllers/class_page.controller.dart';

class AddClassBottomSheet extends GetView<ClassController> {

  const AddClassBottomSheet({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColor.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE SECTION
              Container(
                width: widthScreen * 0.1,
                height: heightScreen * 0.005,
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color:AppColor.black.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical : heightScreen * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.logoTalentaku, scale: 15,),
                    defaultWidthtSpace,
                    Text(
                      'Buat Kelas Baru',
                      style: AppTextStyle.tsTitleBold(AppColor.black),
                    ),
                  ],
                ),
              ),
              // BODY SECTION
              Padding(
                padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                child: Column(
                  children: [
                    CustomTextFormField(
                      loginController: controller.classNameController,
                      labelText: "Nama Kelas",
                    ),
                    spaceHeightNormal,
                    CustomTextFormField(
                      loginController: controller.classDescController,
                      labelText: "Deskripsi Kelas",
                    ),
                    spaceHeightNormal,
                    // CustomTextFormField(
                    //   loginController: controller.classLevelController,
                    //   labelText: "Level Kelas",
                    // ),
                    DropdownButtonFormField<int>(
                    value: controller.selectedLevel.value,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: heightScreen * 0.02,
                        horizontal: widthScreen * 0.05,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.grey),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColor.blue500),
                      ),
                      labelText: 'Level Kelas',
                      labelStyle: AppTextStyle.tsSmallRegular(AppColor.black),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Kelompok Bermain', style: AppTextStyle.tsBodyRegular(AppColor.black)),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Sekolah Dasar', style: AppTextStyle.tsBodyRegular(AppColor.black)),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedLevel.value = value!;
                    },
                    dropdownColor: AppColor.white,                    
                  ),

                  ],
                ),
              ),   
              // BOTTOM ACTION SECTION     
              Container(
                width: widthScreen * 0.9,
                height: heightScreen * 0.002,
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: AppColor.black.withOpacity(0.1),
                ),
              ),  
              Padding(
                padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonActionSecondary(
                      text: 'Kembali', 
                      onPressed: () { Get.back();}
                    ),
                    CustomButtonActionMain(
                      text: 'Buat Kelas', 
                      onPressed: () { controller.createNewClass(); Get.back();}
                    )
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
