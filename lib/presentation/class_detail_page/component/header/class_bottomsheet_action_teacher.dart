import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../../album_form_page/album_form.screen.dart';
import '../../../assignment_page/assignemnt_form_page.screen.dart';
import '../../../common_widget/custom_button_action_main.dart';
import '../../../common_widget/custom_button_action_secondary.dart';
import '../../../common_widget/custom_textFormField.dart';
import '../beranda/widget_announcement_bottomsheet.dart';
import 'edit_class_form.dart';
import 'widget_class_button_action_item.dart';

class ClassBottomsheetActionTeacher extends GetView<ClassDetailController> {

  const ClassBottomsheetActionTeacher({
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
                  borderRadius:defaultBorderRadius,
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
                      '${controller.classItem['name']}',
                      style: AppTextStyle.tsTitleBold(AppColor.black),
                    ),
                    Divider()
                  ],
                ),
              ),           
              
              // BODY SECTION
              Padding(
                padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                child: Column( 
                  children: [
                    CustomWidgetClassButtonActionItem(
                      buttonName: 'Edit Kelas',
                      buttonIcon: Icons.edit_square,
                      onTap: (){
                        Get.back();
                        Get.bottomSheet(EditClassBottomSheet(),
                        isScrollControlled: true,
                      );
                      },
                    ),
                    spaceHeightSmall,
                    CustomWidgetClassButtonActionItem(
                      buttonName: 'Unggah Pengumuman',
                      buttonIcon: Icons.upload_rounded,
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(CustomWidgetAnnouncementBottomsheet(), 
                        isScrollControlled: true);
                      }
                    ),
                    spaceHeightSmall,
                    CustomWidgetClassButtonActionItem(
                      buttonName: 'Unggah Tugas',
                      buttonIcon: Icons.assignment_add,
                      onTap: () => Get.to(() => 
                      AssignemntFormPageScreen(), 
                      arguments: {
                        'taskId' : '',
                        'gradeId': controller.classItem['id'].toString()
                      }),
                    ),
                    spaceHeightSmall,
                    CustomWidgetClassButtonActionItem(
                      buttonName: 'Unggah Foto / Video',
                      buttonIcon: Icons.image,
                      onTap: () => Get.to(
                      () => AlbumFormScreen(), 
                      arguments: {'gradeId' : controller.classItem['id'].toString()}
                    ),
                    ),
                  ],
                ),
              ),   
             
            ],
          ),
      ),
    );
  }
}


