import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_textFormField.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import 'component/circular_icon_button.dart';
import 'controllers/assignment_page.controller.dart';

class AssignemntFormPageScreen extends StatelessWidget {
  AssignemntFormPageScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   Get.lazyPut(() => AssignmentPageController());

    // Retrieve the controller instance
    final AssignmentPageController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColor.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Buat Tugas')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextFormField(
                  loginController: controller.titleController, 
                  labelText: 'Judul Tugas'
                ),                
                spaceHeightSmall,
                 CustomTextFormField(
                  loginController: controller.descController, 
                  labelText: 'Deskripsi Tugas'
                ),                  
                spaceHeightNormal,                
                Row(
                  children: [
                    IconButton(
                    icon: Icon(Icons.file_upload_rounded),
                      color: AppColor.blue600,
                      onPressed: () => controller.pickMedia(ImageSource.gallery)
                    ),
                    Text(
                      'Upload File',
                      style: AppTextStyle.tsBodyBold(AppColor.black),
                    ),
                  ],
                ),
                Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: controller.selectedFiles.map((file) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () => showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierColor: AppColor.black,
                                      pageBuilder: (BuildContext context, Animation first, Animation second) {
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.close, color: Colors.white),
                                                onPressed: () => Get.back(),
                                              ),
                                              SizedBox(height: 16.0),
                                              InteractiveViewer(
                                                child: Image.file(File(file.path)),
                                              ),
                                            ],
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
                                      onTap: () => controller.removeSelectedFile(file),
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
                // Row(
                //   children: [
                //     IconButton(
                //     icon: Icon(Icons.link_rounded),
                //       color: AppColor.blue600,
                //       onPressed: () => controller.addLink()
                //     ),
                //     Text(
                //       'Upload Link',
                //       style: AppTextStyle.tsBodyBold(AppColor.black),
                //     ),
                //   ],
                // ),
                // Obx(() => Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // children: controller.links
                //     .map((link) => Text(link, overflow: TextOverflow.ellipsis,))
                //     .toList(),
                // )),                            
                spaceHeightExtraSmall,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [                      
                      Text('Tenggat :', style: AppTextStyle.tsBodyBold(AppColor.black),),
                      IconButton(
                        onPressed: () => controller.pickDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                      Obx(() {
                        return Flexible(
                          child: AutoSizeText(
                            controller.selectedDate.value != null
                                ? DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(controller.selectedDate.value!)
                                : 'Tidak ada tanggal terpilih',
                            style: AppTextStyle.tsBodyRegular(AppColor.black),
                            minFontSize: 10,
                            softWrap: true,
                            maxLines: 1,
                          ),
                        );
                      }),
                    ],
                  ),
                ),                
                spaceHeightLarge,
                Obx(() {
                  return ElevatedButton(
                    onPressed: () {
                       controller.createTask();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), 
                      backgroundColor: AppColor.blue600,
                      shape: RoundedRectangleBorder(
                        borderRadius: defaultBorderRadius,
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColor.blue200),
                          )
                        : Text(
                            "Buat Tugas",
                            style: AppTextStyle.tsBodyBold(AppColor.white),
                          ),
                        );
                      }),                
              ],
            ),
          ),
        ));
  }
}
