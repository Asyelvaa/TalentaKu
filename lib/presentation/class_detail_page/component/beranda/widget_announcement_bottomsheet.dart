import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../common_widget/custom_button_action_secondary.dart';
import '../../../common_widget/custom_button_action_main.dart';
import '../../controllers/class_detail.controller.dart';

class CustomWidgetAnnouncementBottomsheet extends StatelessWidget {
  const CustomWidgetAnnouncementBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());
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
                      'Buat Pengumuman',
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
                    TextField(
                      controller: controller.announcementController,
                      textAlign: TextAlign.start,                      
                      maxLines: null, 
                      // expands: true, 
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: 'Umumkan sesuatu kepada kelas anda',
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                      style: AppTextStyle.tsSmallRegular(AppColor.black),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.file_upload_rounded),
                          color: AppColor.blue600,
                          onPressed: () => controller.pickFile()
                        ),
                        Text(
                          'Upload File',
                          style: AppTextStyle.tsBodyBold(AppColor.black),
                        ),
                      ],
                    ),
                    spaceHeightExtraSmall,
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SingleChildScrollView(                            
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: controller.pickedFiles.map((file) {
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                            MaterialLocalizations.of(context)
                                                .modalBarrierDismissLabel,
                                        barrierColor: AppColor.black,
                                        pageBuilder: (BuildContext context,
                                            Animation first, Animation second) {
                                          return Center(
                                            child: InteractiveViewer(
                                              child:
                                                  Image.file(File(file.path)),
                                            ),
                                          );
                                        },
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(file.path),
                                          width: widthScreen * 0.3,
                                          height: heightScreen * 0.15,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 4,
                                      top: 4,
                                      child: GestureDetector(
                                        onTap: () => controller
                                            .removeFile(file),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }),                    
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
                      text: 'Batalkan', 
                      onPressed: () {Get.back();}
                    ),
                    CustomButtonActionMain(
                      text: 'Kirim', 
                      onPressed: () { controller.createAnnouncement();}
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