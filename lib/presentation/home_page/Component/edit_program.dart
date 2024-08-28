import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_textFormField.dart';
import 'package:get/get.dart';

import '../controllers/home_page.controller.dart';

class EditProgramPopup extends GetView<HomePageController> {
  final int programId;
  final String initialName;
  final String initialDesc;
  final String initialPhoto;
  final int initialCategoryId;

  EditProgramPopup({
    required this.programId,
    required this.initialName,
    required this.initialDesc,
    required this.initialPhoto,
    required this.initialCategoryId,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final TextEditingController categoryIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = initialName;
    descController.text = initialDesc;
    categoryIdController.text = initialCategoryId.toString();

    return 
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.grey,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                      child: Text(
                        "Edit Program",
                        style: AppTextStyle.tsTitle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),                
                  CustomTextFormField(
                    loginController: nameController, 
                    labelText: "Nama Program"
                  ),
                  spaceHeightNormal,
                  CustomTextFormField(
                    loginController: descController, 
                    labelText: "Deskripsi Program"
                  ),
                  // TextFormField(
                  //   controller: nameController,
                  //   decoration: InputDecoration(
                  //     labelText: "Nama Program",
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: AppColor.grey),
                  //       borderRadius: BorderRadius.all(Radius.circular(12)),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide(color: AppColor.blue500),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: AppColor.blue500),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  // TextFormField(
                  //   controller: descController,
                  //   decoration: InputDecoration(
                  //     labelText: "Deskripsi Program",
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: AppColor.grey),
                  //       borderRadius: BorderRadius.all(Radius.circular(12)),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide(color: AppColor.blue500),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: AppColor.blue500),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Obx(
                      () => controller.selectedImages.isNotEmpty
                      ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(controller.selectedImages.value),
                                        width: widthScreen * 0.3,
                                        height: heightScreen * 0.15,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                          // ? Container(
                          //     width: widthScreen,
                          //     height: heightScreen * 0.2,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       image: DecorationImage(
                          //         image: FileImage(
                          //             File(controller.selectedImages.value)),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   )
                          : Container(
                              height: heightScreen * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: AppColor.blue500),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Tambah Foto",
                                style: AppTextStyle.tsNormal,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.05,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          Get.find<HomePageController>().updateProgram(
                            programId,
                            nameController.text,
                            descController.text,
                            File(controller.selectedImages.value),
                            int.parse(categoryIdController.text),
                          );
                          
                        } catch (e) {
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
                        "Update",
                        style: AppTextStyle.tsNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
