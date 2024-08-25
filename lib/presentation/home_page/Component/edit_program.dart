import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/main.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_button.dart';
import 'package:get/get.dart';

import '../../common_widget/custom_textFormField.dart';
import '../controllers/home_page.controller.dart';

class EditProgramPopup extends StatelessWidget {
  final int programId;
  final String initialName;
  final String initialDesc;
  // final String initialPhoto;
  final int initialCategoryId;

  EditProgramPopup({
    required this.programId,
    required this.initialName,
    required this.initialDesc,
    // required this.initialPhoto,
    required this.initialCategoryId,
  });

  final controller = Get.put(HomePageController());
  
  @override
  Widget build(BuildContext context) {
    controller.nameController.text = initialName;
    controller.descController.text = initialDesc;
    controller.categoryIdController.text = initialCategoryId.toString();

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColor.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,          
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.black.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical : heightScreen * 0.02,),
              child: Text(
                "Edit Program",
                style: AppTextStyle.tsTitleBold(AppColor.black)
              ),
            ),
            CustomTextFormField(
              loginController: controller.nameController, 
              labelText: 'Nama Program'
            ),
            CustomTextFormField(
              loginController: controller.descController, 
              labelText: 'Deskripsi Program'
            ),  
            // if (initialPhoto.isEmpty)
            //   Row(
            //     children: [
            //       IconButton(
            //         icon: Icon(Icons.file_upload_rounded),
            //         color: AppColor.blue600,
            //         onPressed: () => controller.pickImage(),
            //       ),
            //       Text(
            //         'Tambahkan Gambar',
            //         style: AppTextStyle.tsBodyBold(AppColor.black),
            //       ),
            //     ],
            //   ),
            // spaceHeightExtraSmall,
          //   Obx(() {            
          //   return Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Wrap(
          //           spacing: 8.0,
          //           runSpacing: 8.0,
          //           children: controller.programPhotos.map((file) {
          //             return Stack(
          //               children: [
          //                 GestureDetector(
          //                   onTap: () => showGeneralDialog(
          //                     context: context,
          //                     barrierDismissible: true,
          //                     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
          //                     barrierColor: AppColor.black,
          //                     pageBuilder: (BuildContext context, Animation first, Animation second) {
          //                       return Scaffold(
          //                         backgroundColor: Colors.transparent,
          //                         body: Column(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           crossAxisAlignment: CrossAxisAlignment.end,
          //                           children: [
          //                             IconButton(
          //                               icon: Icon(Icons.close, color: Colors.white),
          //                               onPressed: () => Get.back(),
          //                             ),
          //                             SizedBox(height: 16.0),
          //                             InteractiveViewer(
          //                               child: Image.file(File(file.path)),
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(8),
          //                     child: Image.file(
          //                       File(file.path),
          //                       width: widthScreen * 0.3,
          //                       height: heightScreen * 0.15,
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   right: 4,
          //                   top: 4,
          //                   child: GestureDetector(
          //                     onTap: () => controller.removeImage(file),
          //                     child: Container(
          //                       decoration: BoxDecoration(
          //                         color: Colors.red,
          //                         shape: BoxShape.circle,
          //                       ),
          //                       child: Icon(
          //                         Icons.close,
          //                         color: Colors.white,
          //                         size: 20,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             );
          //           }).toList(),
          //         ),
          //       ),
          //     ],
          //   );
          // }),
            Divider(),        
            spaceHeightLarge,
            CustomButton(
              text: 'Update', 
              colorButton: AppColor.blue600, 
              colorText: AppColor.white, 
              onPressed: () {
                 controller.updateProgram(
                      programId,
                      controller.nameController.text,
                      controller.descController.text,

                      int.parse(controller.categoryIdController.text),
                    );    
                },),          
          ],
        ),
      ),
    );
  }
}
