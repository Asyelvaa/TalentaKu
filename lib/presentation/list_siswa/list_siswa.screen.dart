import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/list_siswa/component/ListSiswa.dart';

import 'package:get/get.dart';

import 'controllers/list_siswa.controller.dart';

class ListSiswaScreen extends GetView<ListSiswaController> {
  const ListSiswaScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
        ),
        title: Text(
          'Buat Laporan Harian',
          style: AppTextStyle.tsTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColor.blue200,
                  ));
                }
                if (controller.students.isEmpty) {
                  return Center(child: Text("Tidak ada murid"));
                } else {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.students.length,
                      itemBuilder: (context, index) {
                        final student = controller.students[index];
                        final selected = controller.isSelected[index];
                        return GestureDetector(
                          onTap: () {
                            controller.isSelected.value = List.generate(
                                controller.students.length,
                                (index) => false.obs);
                            controller.studentId.value = student.id!;
                            selected.toggle();
                          },
                          child: Obx(() => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: heightScreen * 0.11,
                                  width: widthScreen,
                                  decoration: BoxDecoration(
                                      color: selected.value
                                          ? AppColor.blue100
                                          : AppColor.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: selected.value
                                                      ? Border.all(
                                                          width: 3,
                                                          color:
                                                              AppColor.blue600)
                                                      : null),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  child: Image.asset(
                                                      'assets/images/student.png')),
                                            ),
                                          ),
                                          defaultWidthtSpace,
                                          AutoSizeText(
                                            student.name!,
                                            style: AppTextStyle.tsSmallRegular(
                                                AppColor.black),
                                            minFontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      });
                }
              }),
            ),
            // Tambahkan tombol di sini
            Obx(() {
              final selectedStudent = controller.students.firstWhereOrNull(
                  (student) => student.id == controller.studentId.value);
              return ElevatedButton(
                onPressed: selectedStudent == null
                    ? null
                    : () {
                        Get.toNamed(Routes.STUDENT_REPORT_FORM, arguments: {
                          "studentId": selectedStudent.id,
                          "gradeId": controller.classItem["id"].toString(),
                        });
                      },
                child: Text(
                  selectedStudent == null
                      ? "Pilih murid untuk mengirim laporan"
                      : "Kirim Laporan untuk ${selectedStudent.name}",
                  style: AppTextStyle.tsNormal.copyWith(
                    color: AppColor.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    selectedStudent == null ? AppColor.grey : AppColor.blue500,
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
