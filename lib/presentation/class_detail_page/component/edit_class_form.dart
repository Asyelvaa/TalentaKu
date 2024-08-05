import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../../domain/models/class_model.dart';
import '../../common_widget/text_background.dart';
import 'profile_name_avatar.dart';

class EditClassBottomSheet extends GetView<ClassDetailController> {
  const EditClassBottomSheet({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final grade = controller.dataClass.value;
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColor.white,
      ),
      child: Column(
        children: [
          // HEADER
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
                    'Pengaturan Kelas',
                    style: AppTextStyle.tsTitleBold(AppColor.black),
                  ),
                ],
              ),
            ),
          // BODY
          
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('Kode Kelas', style: AppTextStyle.tsBodyBold(AppColor.black))),
                            TextWithBackground(
                              colorBackground: AppColor.blue200, 
                              text: controller.dataClass.value.uniqueCode! ?? '',
                              ),
                              SizedBox(width: 4,),
                            GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: grade.uniqueCode!));
                              Get.snackbar('Salin Kode', 'Kode Kelas berhasil di salin', 
                              snackPosition: SnackPosition.TOP, 
                              backgroundColor: AppColor.blue200,                              
                              );
                            },
                            child: Icon(
                              Icons.copy_rounded,
                              size: 20,
                            ),
                          ),
                          ],
                        ),
                        
                        Text('Nama Kelas', style: AppTextStyle.tsBodyBold(AppColor.black)),
                        TextField(
                          controller: controller.classNameController,
                          decoration: InputDecoration(
                            hintText: grade.name,
                            hintStyle: AppTextStyle.tsNormal,
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.blue200),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.blue600, width: 1),
                            ),
                          ),                  
                        ),
                        Text('Deskripsi Kelas',style: AppTextStyle.tsBodyBold(AppColor.black)),                        
                        TextField(
                          controller: controller.classDescController,
                          decoration: InputDecoration(
                            hintText: grade.desc,
                            hintStyle: AppTextStyle.tsNormal,
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.blue200),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.blue600, width: 1),
                            ),
                          ),
                        ),
                        Text('Level Kelas',style: AppTextStyle.tsBodyBold(AppColor.black)),
                        TextField(
                          controller: controller.classLevelController,
                          decoration: InputDecoration(
                            hintText: grade.levelName,
                            hintStyle: AppTextStyle.tsNormal,
                            fillColor: AppColor.grey,
                            
                          ),
                        ),                        
                        Row(children: [
                          Text('Guru Kelas : ',style: AppTextStyle.tsBodyBold(AppColor.black)),
                          Text('${grade.teacher!}' ,style: AppTextStyle.tsNormal),
                        ],),
                       Text('Anggota Kelas', style: AppTextStyle.tsBodyBold(AppColor.black)),
                      grade.member == null || grade.member!.isEmpty
                        ? Text('Belum ada siswa yang bergabung', style: AppTextStyle.tsNormal)
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: grade.member!.length,
                            itemBuilder: (context, index) {
                              final member = grade.member![index];
                              return ListTile(
                                title: Text(
                                  member.name!,
                                  style: AppTextStyle.tsLittle,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: AppColor.blue100,
                                  child: Text(member.name![0]),
                                ),
                              );
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Active Class',
                                  style: AppTextStyle.tsBodyBold(AppColor.black)),
                              Switch(
                                activeColor: AppColor.blue600,
                                value: grade.isActiveStatus == "active",
                                onChanged: (value) {
                                  controller.toggleActiveStatus(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // BOTTOM ACTION SECTION
                ],
              ),
            ),
          ),
          // BOTTOM
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text('Kembali',
                    style: AppTextStyle.tsNormal
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: () {
                  // controller.updateGradeDetails();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0),
                child: Text('Simpan',
                    style: AppTextStyle.tsNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
