import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_talentaku/presentation/edit__report_user_page/component/form_user.dart';
import 'package:get/get.dart';
import '../../../infrastructure/theme/theme.dart';
import 'controllers/edit_report_user_page.controller.dart';

class EditReportUserPageScreen extends GetView<EditReportUserPageController> {
  const EditReportUserPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
        ),
        title: Text(
          'Edit Laporan Harian',
          style: AppTextStyle.tsTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 250,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)),
                                  color: AppColor.background,
                                ),
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    controller.createdController.text =
                                        "${newDateTime.year}/${newDateTime.month}/${newDateTime.day}";
                                  },
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ),
                              CupertinoButton(
                                color: AppColor.blue100,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Text(
                                  'Done',
                                  style: AppTextStyle.tsLittle,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 155,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: AppColor.blue500),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: controller.createdController,
                      decoration: InputDecoration(
                        labelText: "YYYY/MM/DD",
                        hintStyle: AppTextStyle.tsLittle,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppColor.blue500),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    controller: controller.semesterIdController,
                    decoration: InputDecoration(
                      labelText: "Semester ID",
                      hintStyle: AppTextStyle.tsLittle,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightScreen * 0.02),
            Text("Kegiatan Awal", style: AppTextStyle.tsTitle),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.kegiatanAwalTextController,
              controller: controller,
              sectionTitle: "Kegiatan Awal",
              pointType: 'Muncul',
            ),
            SizedBox(height: heightScreen * 0.02),
            Text("Kegiatan Inti", style: AppTextStyle.tsTitle),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.kegiatanIntiTextController,
              controller: controller,
              sectionTitle: "Kegiatan Inti",
              pointType: 'Kurang',
            ),
            SizedBox(height: heightScreen * 0.02),
            Text("Snack", style: AppTextStyle.tsTitle),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.SnackTextController,
              controller: controller,
              sectionTitle: "Snack",
              pointType: 'Belum Muncul',
            ),
            SizedBox(height: heightScreen * 0.02),
            Text("Inklusi", style: AppTextStyle.tsTitle),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.inklusiTextController,
              controller: controller,
              sectionTitle: "Inklusi",
              pointType: 'Muncul',
            ),
            SizedBox(height: heightScreen * 0.02),
            Text("Catatan", style: AppTextStyle.tsTitle),
            SizedBox(height: heightScreen * 0.02),
            Container(
              height: heightScreen * 0.08,
              width: widthScreen * 1,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: AppColor.blue500),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: controller.catatanController,
                decoration: InputDecoration(
                  hintText: "Masukkan Catatan",
                  hintStyle: AppTextStyle.tsLittle,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
            SizedBox(height: heightScreen * 0.02),
            GestureDetector(
              onTap: () {
                controller.pickImage();
              },
              child: Obx(() {
                return Container(
                  height: heightScreen * 0.4,
                  width: widthScreen * 1,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppColor.blue500),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: controller.selectedImage.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        )
                      : Text("+ Foto / Video Baru",
                          style: AppTextStyle.tsNormal),
                );
              }),
            ),
            SizedBox(height: heightScreen * 0.02),
            // Text("Kirim Laporan untuk", style: AppTextStyle.tsTitle),
            // SizedBox(height: heightScreen * 0.02),
            // Obx(() {
            //   if (controller.isLoading.value) {
            //     return Center(child: CircularProgressIndicator());
            //   }
            //   if (controller.students.isEmpty) {
            //     return Center(child: Text("Tidak ada murid"));
            //   }
            //   return Wrap(
            //     spacing: 10,
            //     children: controller.students.map((student) {
            //       final isSelected =
            //           controller.selectedStudents.contains(student);
            //       return GestureDetector(
            //         onTap: () => controller.toggleSelection(student),
            //         child: Column(
            //           children: [
            //             CircleAvatar(
            //               radius: 30,
            //               backgroundImage: student.photo != null
            //                   ? NetworkImage(student.photo!)
            //                   : AssetImage('assets/images/anak.png')
            //                       as ImageProvider,
            //               backgroundColor:
            //                   isSelected ? Colors.blue : Colors.grey,
            //             ),
            //             SizedBox(height: 5),
            //             Text(student.name),
            //           ],
            //         ),
            //       );
            //     }).toList(),
            //   );
            // }),
            SizedBox(height: heightScreen * 0.03),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      
                      final int reportId = controller.reportUser['id'] ?? 0;

                      controller.editReport(
                        created: controller.createdController.text,
                        semesterId:
                            int.parse(controller.semesterIdController.text),
                        kegiatanAwal:
                            controller.kegiatanAwalTextController.text,
                        awalPoint:
                            controller.selectedOptions['Kegiatan Awal'] ?? '',
                        kegiatanInti:
                            controller.kegiatanIntiTextController.text,
                        intiPoint:
                            controller.selectedOptions['Kegiatan Inti'] ?? '',
                        snack: controller.SnackTextController.text,
                        snackPoint: controller.selectedOptions['Snack'] ?? '',
                        inklusi: controller.inklusiTextController.text,
                        inklusiPoint:
                            controller.selectedOptions['Inklusi'] ?? '',
                        catatan: controller.catatanController.text,
                        media: controller.selectedImage.value != null
                            ? [controller.selectedImage.value!]
                            : [],
                        reportId: reportId,
                      );
                      Get.back(result: 'success');
                    },
                    child: Container(
                      height: heightScreen * 0.07,
                      decoration: BoxDecoration(
                        color: AppColor.blue100,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child:
                            Text("Edit Laporan", style: AppTextStyle.tsNormal),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      int reportId = controller.reportUser['id'] ?? 1;
                      controller.deleteReport(reportId);
                      Get.back(result: 'success');
                    },
                    child: Container(
                      height: heightScreen * 0.07,
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: Text("Hapus Laporan",
                            style: AppTextStyle.tsNormal
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
