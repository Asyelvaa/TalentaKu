import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/header_class.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../infrastructure/theme/theme.dart';
import '../common_widget/custom_textFormField.dart';
import 'component/form.dart';
import 'controllers/student_report_form.controller.dart';

class StudentReportFormScreen extends GetView<StudentReportFormController> {
  const StudentReportFormScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: widthScreen * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppColor.blue500),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => controller.pickDate(context),
                        icon: Icon(
                          Icons.calendar_today,
                          color: AppColor.blue500,
                        ),
                      ),
                      Obx(() {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            controller.selectedDate.value != null
                                ? '${DateFormat('dd - MM - yyyy', 'id_ID').format(controller.selectedDate.value!)}'
                                : 'Pilih tanggal',
                            style: AppTextStyle.tsNormal,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  width: widthScreen * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppColor.blue500),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      hintStyle: AppTextStyle.tsNormal,
                    ),
                    hintText: 'Pilih Semester',
                    items: ['1', '2'],
                    onChanged: (value) {
                      if (value != null) {
                        controller.semesterIdController.text =
                            value; // Update the controller's text
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: heightScreen * 0.02),
            Text(
              "Kegiatan di Halaman",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.kegiatan_awal_dihalamanTextController,
              controller: controller,
              sectionTitle: "Kegiatan di Halaman",
              pointType: 'Muncul',
            ),
            defaultHeightSpace,
            Text(
              "Kegiatan Awal Berdoa",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.kegiatan_awal_berdoaTextController,
              controller: controller,
              sectionTitle: "Kegiatan Awal Berdoa",
              pointType: 'Muncul',
            ),
            defaultHeightSpace,
            Text(
              "Kegiatan Inti",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.kegiatan_inti_satuTextController,
              controller: controller,
              sectionTitle: "Kegiatan Inti",
              pointType: 'Muncul',
            ),

            spaceHeightSmall,
            FormSection(
              textController: controller.kegiatan_inti_duaTextController,
              controller: controller,
              sectionTitle: "Kegiatan Inti dua",
              pointType: 'Belum Muncul',
            ),

            spaceHeightSmall,
            FormSection(
              textController: controller.kegiatan_inti_tigaTextController,
              controller: controller,
              sectionTitle: "Kegiatan Inti tiga",
              pointType: 'Belum Muncul',
            ),
            defaultHeightSpace,
            // Snack section
            Text(
              "Snack",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.SnackTextController,
              controller: controller,
              sectionTitle: "Snack",
              pointType: 'Belum Muncul',
            ),
            spaceHeightSmall,
            // Inklusi section
            Text(
              "Inklusi",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.inklusiTextController,
              controller: controller,
              sectionTitle: "Inklusi",
              pointType: 'Muncul',
            ),
            spaceHeightSmall,
            Text(
              "Berdoa",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.inklusi_doaTextController,
              controller: controller,
              sectionTitle: "Doa",
              pointType: 'Muncul',
            ),
            defaultHeightSpace,
            Text(
              "Penutup",
              style: AppTextStyle.tsBodyBold(Colors.black),
            ),
            spaceHeightSmall,
            FormSection(
              textController: controller.inklusi_penutupTextController,
              controller: controller,
              sectionTitle: "Penutup",
              pointType: 'Muncul',
            ),
            defaultHeightSpace,
            // Catatan section
            Text(
              "Catatan Laporan",
              style: AppTextStyle.tsBodyBold(AppColor.black),
            ),
            spaceHeightSmall,
            CustomTextFormField(
              loginController: controller.catatanController,
              labelText: "Masukkan Catatan",
            ),
            spaceHeightSmall,
            SizedBox(height: heightScreen * 0.01),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.file_upload_rounded),
                    color: AppColor.blue600,
                    onPressed: () => controller.pickImage()),
                Text(
                  'Upload Foto ',
                  style: AppTextStyle.tsBodyBold(AppColor.black),
                ),
              ],
            ),
            spaceHeightExtraSmall,
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: controller.selectedImages.map((file) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () => showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: MaterialLocalizations.of(context)
                                    .modalBarrierDismissLabel,
                                barrierColor: AppColor.black,
                                pageBuilder: (BuildContext context,
                                    Animation first, Animation second) {
                                  return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close,
                                              color: Colors.white),
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
                                onTap: () => controller.removeImage(file),
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
            spaceHeightNormal,
          
           
            defaultHeightSpace,
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (controller.studentId.value != 0) {
                            controller.submitReport(
                              created: controller.selectedDate.value.toString(),
                              semesterId: int.parse(
                                  controller.semesterIdController.text),
                              snack: controller.SnackTextController.text,
                              inklusi: controller.inklusiTextController.text,
                              inklusiHasil:
                                  controller.selectedOptions['Inklusi']!,
                              catatan:
                                  controller.catatanController.text.split(','),
                              media: controller.selectedImages,
                              studentId: controller.studentId.value,
                              kegiatanAwalDihalaman: controller
                                  .kegiatan_awal_dihalamanTextController.text,
                              dihalamanHasil: controller
                                  .selectedOptions['Kegiatan di Halaman']!,
                              kegiatanAwalBerdoa: controller
                                  .kegiatan_awal_berdoaTextController.text,
                              berdoaHasil: controller
                                  .selectedOptions['Kegiatan Awal Berdoa']!,
                              kegiatanIntiSatu: controller
                                  .kegiatan_inti_satuTextController.text,
                              intiSatuHasil:
                                  controller.selectedOptions['Kegiatan Inti']!,
                              kegiatanIntiDua: controller
                                  .kegiatan_inti_duaTextController.text,
                              intiDuaHasil: controller
                                  .selectedOptions['Kegiatan Inti dua']!,
                              kegiatanIntiTiga: controller
                                  .kegiatan_inti_tigaTextController.text,
                              intiTigaHasil: controller
                                  .selectedOptions['Kegiatan Inti tiga']!,
                              inklusiPenutup:
                                  controller.inklusi_penutupTextController.text,
                              inklusiPenutupHasil:
                                  controller.selectedOptions['Penutup']!,
                              inklusiDoa:
                                  controller.inklusi_doaTextController.text,
                              inklusiDoaHasil:
                                  controller.selectedOptions['Doa']!,
                            );
                          } else {
                            Get.snackbar('Peringatan', 'Harap pilih siswa',
                                backgroundColor: AppColor.red);
                          }
                        },
                  color: AppColor.blue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColor.blue200),
                        )
                      : Text(
                          "Kirim Laporan",
                          style: AppTextStyle.tsNormal
                              .copyWith(color: Colors.white),
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
