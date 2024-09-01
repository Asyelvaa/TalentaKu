import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/presentation/edit__report_user_page/model/Studen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../infrastructure/theme/theme.dart';
import 'component/form_user.dart';
import 'controllers/edit_report_user_page.controller.dart';

class EditReportUserPageScreen extends StatelessWidget {
  const EditReportUserPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    final controller = Get.put(EditReportUserPageController());

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
                Icon(
                  Icons.calendar_month,
                  color: AppColor.blue500,
                ),
                defaultWidthtSpace,
                Text(
                  '${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now())}',
                  style: AppTextStyle.tsTitle,
                ),
              ],
            ),
            SizedBox(height: heightScreen * 0.02),
            Text("Kegiatan Awal di Halaman", style: AppTextStyle.tsTitle),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_awal_dihalamanTextController,
              controller: controller,
              sectionTitle: "kegiatan_awal_dihalaman",
              pointType: 'Muncul',
            ),
            defaultHeightSpace,
            Text("Kegiatan Berdoa", style: AppTextStyle.tsTitle),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_awal_berdoaTextController,
              controller: controller,
              sectionTitle: "kegiatan_awal_berdoa",
              pointType: 'Kurang',
            ),
            defaultHeightSpace,
            Text(
              "Kegiatan Inti",
              style: AppTextStyle.tsTitle,
            ),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_inti_satuTextController,
              controller: controller,
              sectionTitle: "kegiatan_inti_satu",
              pointType: 'Kurang',
            ),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_inti_duaTextController,
              controller: controller,
              sectionTitle: "kegiatan_inti_dua",
              pointType: 'Kurang',
            ),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_inti_tigaTextController,
              controller: controller,
              sectionTitle: "kegiatan_inti_tiga",
              pointType: 'Kurang',
            ),
            spaceHeightNormal,
            Text("Snack", style: AppTextStyle.tsTitle),
            spaceHeightSmall,
            Container(
              height: heightScreen * 0.08,
              width: widthScreen * 1,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: AppColor.blue500),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: controller.SnackTextController,
                decoration: InputDecoration(
                  hintText: "Snack",
                  hintStyle: AppTextStyle.tsLittle,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                maxLines: null,
                minLines: 1,
              ),
            ),
            spaceHeightNormal,
            Text("Inklusi Doa", style: AppTextStyle.tsTitle),
            spaceHeightSmall,
            FormSection(
              textController: controller.inklusi_doaTextController,
              controller: controller,
              sectionTitle: "inklusi_doa",
              pointType: 'Muncul',
            ),
            spaceHeightNormal,
            Text("Inklusi Penutup", style: AppTextStyle.tsTitle),
            spaceHeightSmall,
            FormSection(
              textController: controller.inklusi_penutupTextController,
              controller: controller,
              sectionTitle: "inklusi_penutup",
              pointType: 'Muncul',
            ),
            spaceHeightNormal,
            Text("Inklusi", style: AppTextStyle.tsTitle),
            spaceHeightSmall,
            FormSection(
              textController: controller.inklusiTextController,
              controller: controller,
              sectionTitle: "inklusi",
              pointType: 'Muncul',
            ),
            spaceHeightNormal,
            Text("Catatan", style: AppTextStyle.tsTitle),
            spaceHeightSmall,
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
                maxLines: null,
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
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.file_upload_rounded),
                  color: AppColor.blue600,
                  onPressed: () => controller.pickImage(),
                ),
                Text(
                  'Upload Foto ',
                  style: AppTextStyle.tsBodyBold(AppColor.black),
                ),
              ],
            ),
            spaceHeightExtraSmall,
            Obx(() {
              return controller.selectedImage.value != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () => showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel:
                                          MaterialLocalizations.of(context)
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
                                                child: Image.file(File(
                                                    controller.selectedImage
                                                        .value!.path)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(controller
                                            .selectedImage.value!.path),
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
                                      onTap: () =>
                                          controller.selectedImage.value = null,
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink();
            }),
            SizedBox(height: heightScreen * 0.02),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final int reportId = controller.reportUser['id'] ?? 0;

                      controller.editReport(
                        kegiatan_awal_dihalaman: controller
                            .kegiatan_awal_dihalamanTextController.text,
                        dihalaman_hasil: controller
                                .selectedOptions['kegiatan_awal_dihalaman'] ??
                            '',
                        kegiatan_awal_berdoa:
                            controller.kegiatan_awal_berdoaTextController.text,
                        berdoa_hasil: controller
                                .selectedOptions['kegiatan_awal_berdoa'] ??
                            '',
                        kegiatan_inti_satu:
                            controller.kegiatan_inti_satuTextController.text,
                        inti_satu_hasil:
                            controller.selectedOptions['kegiatan_inti_satu'] ??
                                '',
                        kegiatan_inti_dua:
                            controller.kegiatan_inti_duaTextController.text,
                        inti_dua_hasil:
                            controller.selectedOptions['kegiatan_inti_dua'] ??
                                '',
                        kegiatan_inti_tiga:
                            controller.kegiatan_inti_tigaTextController.text,
                        inti_tiga_hasil:
                            controller.selectedOptions['kegiatan_inti_tiga'] ??
                                '',
                        snack: controller.SnackTextController.text,
                        inklusi_doa: controller.inklusi_doaTextController.text,
                        doa_hasil:
                            controller.selectedOptions['inklusi_doa'] ?? '',
                        inklusi_penutup:
                            controller.inklusi_penutupTextController.text,
                        inklusi_penutup_hasil:
                            controller.selectedOptions['inklusi_penutup'] ?? '',
                        inklusi: controller.inklusiTextController.text,
                        inklusi_hasil:
                            controller.selectedOptions['inklusi'] ?? '',
                        catatan: controller.catatanController.text,
                        media: controller.selectedImage.value != null
                            ? [controller.selectedImage.value!]
                            : [],
                        reportId: reportId,
                      );
                    },
                    child: Container(
                      height: heightScreen * 0.06,
                      decoration: BoxDecoration(
                        color: AppColor.blue500,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Obx(() {
                        return controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Simpan',
                                style: AppTextStyle.tsNormal,
                              );
                      }),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between buttons
                // "Delete" button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final int reportId = controller.reportUser['id'] ?? 0;
                      if (reportId != 0) {
                        controller.deleteReport(reportId);
                      } else {
                        Get.snackbar(
                          'Error',
                          'Invalid report ID',
                          backgroundColor: AppColor.red,
                        );
                      }
                    },
                    child: Container(
                      height: heightScreen * 0.06,
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Obx(() {
                        return controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Hapus',
                                style: AppTextStyle.tsNormal,
                              );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightScreen * 0.02),
          ],
        ),
      ),
    );
  }
}
