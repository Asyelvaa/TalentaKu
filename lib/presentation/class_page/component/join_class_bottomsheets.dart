import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../controllers/class_page.controller.dart';

class JoinClassBottomsheets extends GetView<ClassController> {
  final Function(String) onJoinClass;

  const JoinClassBottomsheets({
    Key? key,
    required this.onJoinClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassController());
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
                  'Buat Kelas',
                  style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
                ),
              ),
              // BODY SECTION
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kode Kelas', style: AppTextStyle.tsLittle),
                        Text('098UYT4D')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                          // controller: controller.classController,
                          decoration: InputDecoration(
                            hintText: 'Nama Kelas',
                            hintStyle: AppTextStyle.tsNormal,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.blue200),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.blue600, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                      ),
                    ),
                    Text('Pilih siswa atau bagikan kode kelas untuk menambahkan member kelas', style: AppTextStyle.tsLittle,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                          // controller: controller.classController,
                          decoration: InputDecoration(
                            hintText: 'Pilih Siswa',
                            hintStyle: AppTextStyle.tsNormal,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppColor.blue200, width: 1)
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                      ),
                    ),
                  ],
                ),
              ),   
              // BOTTOM ACTION SECTION       
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
                    child: Text('Kembali', style: AppTextStyle.tsNormal.copyWith(fontWeight: FontWeight.bold)),
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
                      elevation: 0
                    ),
                    child: Text('Buat', style: AppTextStyle.tsNormal
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    )),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
