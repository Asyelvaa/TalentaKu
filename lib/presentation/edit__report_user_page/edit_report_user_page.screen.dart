import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_talentaku/presentation/edit__report_user_page/component/form_user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../infrastructure/theme/theme.dart';
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
                Icon(Icons.calendar_month, color: AppColor.blue500,),
                defaultWidthtSpace,
                Text('${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now())}', style: AppTextStyle.tsTitle),
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
              "Kegiatan Inti Satu",
              style: AppTextStyle.tsTitle,
            ),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_inti_satuTextController,
              controller: controller,
              sectionTitle: "kegiatan_inti_satu",
              pointType: 'Kurang',
            ),
            defaultHeightSpace,
            Text(
              "Kegiatan Inti Dua",
              style: AppTextStyle.tsTitle,
            ),
            spaceHeightNormal,
            FormSection(
              textController: controller.kegiatan_inti_duaTextController,
              controller: controller,
              sectionTitle: "kegiatan_inti_dua",
              pointType: 'Kurang',
            ),
            spaceHeightNormal,
            Text(
              "Kegiatan Inti Tiga",
              style: AppTextStyle.tsTitle,
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
            spaceHeightNormal,
            FormSection(
              textController: controller.SnackTextController,
              controller: controller,
              sectionTitle: "snack",
              pointType: 'Belum Muncul',
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
                    onPressed: () => controller.pickImage()),
                Text(
                  'Upload Foto ',
                  style: AppTextStyle.tsBodyBold(AppColor.black),
                ),
              ],
            ),
            spaceHeightExtraSmall,
            // Obx(() {
            //   return Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Wrap(
            //           spacing: 8.0,
            //           runSpacing: 8.0,
            //           children: controller.selectedImage.value.map((file) {
            //             return Stack(
            //               children: [
            //                 GestureDetector(
            //                   onTap: () => showGeneralDialog(
            //                     context: context,
            //                     barrierDismissible: true,
            //                     barrierLabel: MaterialLocalizations.of(context)
            //                         .modalBarrierDismissLabel,
            //                     barrierColor: AppColor.black,
            //                     pageBuilder: (BuildContext context,
            //                         Animation first, Animation second) {
            //                       return Scaffold(
            //                         backgroundColor: Colors.transparent,
            //                         body: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.end,
            //                           children: [
            //                             IconButton(
            //                               icon: Icon(Icons.close,
            //                                   color: Colors.white),
            //                               onPressed: () => Get.back(),
            //                             ),
            //                             SizedBox(height: 16.0),
            //                             InteractiveViewer(
            //                               child: Image.file(File(file.path)),
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                   child: ClipRRect(
            //                     borderRadius: BorderRadius.circular(8),
            //                     child: Image.file(
            //                       File(file.path),
            //                       width: widthScreen * 0.3,
            //                       height: heightScreen * 0.15,
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   right: 4,
            //                   top: 4,
            //                   child: GestureDetector(
            //                     onTap: () => controller.removeImage(file),
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                         color: Colors.red,
            //                         shape: BoxShape.circle,
            //                       ),
            //                       child: Icon(
            //                         Icons.close,
            //                         color: Colors.white,
            //                         size: 20,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           }).toList(),
            //         ),
            //       ),
            //     ],
            //   );
            // }),            
            SizedBox(height: heightScreen * 0.02),            
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final int reportId = controller.reportUser['id'] ?? 0;

                      controller.editReport(                        
                        kegiatan_awal_dihalaman: controller.kegiatan_awal_dihalamanTextController.text,
                        dihalaman_hasil: controller.selectedOptions['kegiatan_awal_dihalaman'] ?? '',
                        kegiatan_awal_berdoa:controller.kegiatan_awal_berdoaTextController.text,
                        berdoa_hasil: controller.selectedOptions['kegiatan_awal_berdoa'] ??'',
                        kegiatan_inti_satu:controller.kegiatan_inti_satuTextController.text,
                        inti_satu_hasil:controller.selectedOptions['kegiatan_inti_satu'] ??    '',
                        kegiatan_inti_dua:controller.kegiatan_inti_duaTextController.text,
                        inti_dua_hasil:controller.selectedOptions['kegiatan_inti_dua'] ??    '',
                        kegiatan_inti_tiga:controller.kegiatan_inti_tigaTextController.text,
                        inti_tiga_hasil:controller.selectedOptions['kegiatan_inti_tiga'] ??    '',
                        inklusi_penutup:controller.inklusi_penutupTextController.text,
                        inklusi_penutup_hasil:controller.selectedOptions['inklusi_penutup'] ?? '',
                        inklusi_doa: controller.inklusi_doaTextController.text,
                        doa_hasil:controller.selectedOptions['inklusi_doa'] ?? '',
                        snack: controller.SnackTextController.text,
                        inklusi: controller.inklusiTextController.text,
                        inklusi_hasil:controller.selectedOptions['inklusi'] ?? '',
                        catatan: controller.catatanController.text,
                        media: controller.selectedImage.value != null
                            ? [controller.selectedImage.value!]
                            : [],
                        reportId: reportId,
                      );
                      Get.back(result: 'success $reportId');
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
