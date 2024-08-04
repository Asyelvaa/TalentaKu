import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../global_component/text_background.dart';

class EditClassBottomSheet extends GetView<ClassDetailController> {
  const EditClassBottomSheet({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final grade = controller.grade.value;
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
                            Expanded(child: Text('Kode Kelas', style: AppTextStyle.tsNormal)),
                            TextWithBackground(
                              colorBackground: AppColor.blue200, 
                              text: grade.uniqueCode
                              ),
                              SizedBox(width: 4,),
                            Icon(
                              Icons.copy_rounded,
                              size: 20,
                            )
                          ],
                        ),
                        Text('Nama Kelas', style: AppTextStyle.tsNormal),
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
                        Text('Deskripsi Kelas', style: AppTextStyle.tsNormal),
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
                        Text('Level Kelas', style: AppTextStyle.tsNormal),
                        TextField(
                          controller: controller.classLevelController,
                          decoration: InputDecoration(
                            hintText: grade.level.toString(),
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
                        Row(children: [
                          Text('Guru Kelas : ',style: AppTextStyle.tsNormal),
                          Text('${grade.teacherId}' ,style: AppTextStyle.tsNormal),
                        ],),
                        Text('Anggota Kelas', style: AppTextStyle.tsNormal),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: grade.member.length,
                          itemBuilder: (context, index) {
                            final member = grade.member[index];
                            return ListTile(
                              title: Text(member.name, style: AppTextStyle.tsLittle,),
                              leading: CircleAvatar(
                                backgroundColor: AppColor.blue100,
                                child: Text(member.name[0]),
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
                                  style: AppTextStyle.tsNormal),
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
