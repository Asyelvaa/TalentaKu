import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:flutter_talentaku/presentation/class_page/controllers/class_page.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../../domain/models/class_model.dart';
import '../../global_component/text_background.dart';
import 'profile_name_avatar.dart';

class EditClassBottomSheet extends GetView<ClassDetailController> {
  const EditClassBottomSheet({Key? key, required this.grade}) : super(key: key);
  final GradeModel grade;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     color: AppColor.white,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Nama Kelas: ${grade.name}', style: AppTextStyle.tsNormal),
    //       SizedBox(height: 8),
    //       Text('Kode Kelas: ${grade.uniqueCode}', style: AppTextStyle.tsNormal),
    //       SizedBox(height: 8),
    //       Text('Deskripsi: ${grade.desc}', style: AppTextStyle.tsNormal),
    //       SizedBox(height: 8),
    //       Text('Level: ${grade.level}', style: AppTextStyle.tsNormal),
    //       SizedBox(height: 8),
    //       Text('Pengajar: ${grade.teacherId}', style: AppTextStyle.tsNormal),
    //       SizedBox(height: 8),
    //       Text('Status Aktif: ${grade.isactive}', style: AppTextStyle.tsNormal),
    //       SizedBox(height: 16),
    //       Text('Anggota Kelas:', style: AppTextStyle.tsNormal),
    //       ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: grade.member.length,
    //         itemBuilder: (context, index) {
    //           final member = grade.member[index];
    //           return ProfileNameAvatar(
    //             name: member.name,
    //             profile: member.photo,
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
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
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Pengaturan Kelas',
              style: AppTextStyle.tsTitle.copyWith(fontSize: 16),
            ),
          ),
          // BODY
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('Kode Kelas', style: AppTextStyle.tsNormal)),
                            TextWithBackground(
                              colorBackground: AppColor.blue200, 
                              text: grade.uniqueCode
                              ),
                            Icon(
                              Icons.copy_rounded,
                              size: 20,
                            )
                          ],
                        ),
                        Text('Nama Kelas', style: AppTextStyle.tsNormal),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextField(
                            // controller: controller.classNameController,
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
                        ),
                        Text('Deskripsi Kelas', style: AppTextStyle.tsNormal),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextField(
                            // controller: controller.classDescController,
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
                        ),
                        Row(children: [
                          Text('Level',style: AppTextStyle.tsNormal),
                          Text('${grade.level}' ,style: AppTextStyle.tsNormal),
                        ],),
                        Row(children: [
                          Text('Guru Kelas',style: AppTextStyle.tsNormal),
                          Text('${grade.teacherId}' ,style: AppTextStyle.tsNormal),
                        ],),
                        Text('Anggota Kelas', style: AppTextStyle.tsNormal),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: grade.member.length,
                          itemBuilder: (context, index) {
                            final member = grade.member[index];
                            return ProfileNameAvatar(
                              name: member.name,
                              profile: member.photo,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Archive Class',
                                  style: AppTextStyle.tsNormal),
                              Text(grade.isactive),
                              Switch(
                                value: grade.isactive == "active",
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
                  Get.back();
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
