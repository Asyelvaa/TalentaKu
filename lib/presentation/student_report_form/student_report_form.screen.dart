import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/header_class.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../infrastructure/theme/theme.dart';
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
                  width: 155,
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
                        return Text(
                          controller.selectedDate.value != null
                              ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                              : 'Pilih tanggal',
                          style: AppTextStyle.tsNormal,
                        );
                      }),
                    ],
                  ),
                ),
                // Container(
                //   height: 50,
                //   width: 155,
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1.5, color: AppColor.blue500),
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   alignment: Alignment.center,
                //   child: GestureDetector(
                //     onTap: () {
                //       showModalBottomSheet(
                //         context: context,
                //         builder: (context) {
                //           return Container(
                //             height: 250,
                //             child: Column(
                //               children: [
                //                 Container(
                //                   height: 200,
                //                   decoration: BoxDecoration(
                //                       borderRadius:
                //                           BorderRadius.all(Radius.circular(22)),
                //                       color: AppColor.background),
                //                   child: CupertinoDatePicker(
                //                     initialDateTime: DateTime.now(),
                //                     onDateTimeChanged: (DateTime newDateTime) {
                //                       controller.createdController.text =
                //                           "${newDateTime.year}/${newDateTime.month}/${newDateTime.day}";
                //                     },
                //                     use24hFormat: true,
                //                     mode: CupertinoDatePickerMode.date,
                //                   ),
                //                 ),
                //                 CupertinoButton(
                //                   color: AppColor.blue100,
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(12)),
                //                   child: Text(
                //                     'Done',
                //                     style: AppTextStyle.tsLittle,
                //                   ),
                //                   onPressed: () {
                //                     Navigator.of(context).pop();
                //                   },
                //                 )
                //               ],
                //             ),
                //           );
                //         },
                //       );
                //     },
                //     child: TextFormField(
                //       controller: controller.createdController,
                //       decoration: InputDecoration(
                //         labelText: "YYYY/MM/DD",
                //         hintStyle: AppTextStyle.tsLittle,
                //         border: InputBorder.none,
                //         contentPadding:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //       ),
                //       enabled: false,
                //     ),
                //   ),
                // ),

                Container(
                  width: 155,
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
              "Catatan",
              style: AppTextStyle.tsSmallRegular(AppColor.black),
            ),
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
                  hintStyle: AppTextStyle.tsBodyBold(AppColor.black),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                onChanged: (value) {
                  // Update catatan in the controller
                  // Example: controller.catatan = value;
                },
              ),
            ),
            spaceHeightSmall,
            Row(
              children: [
                Icon(
                  Iconsax.document_upload,
                  color: AppColor.blue400,
                ),
                SizedBox(width: widthScreen * 0.02),
                Text("Upload Foto",
                    style: AppTextStyle.tsBodyBold(AppColor.black))
              ],
            ),
            SizedBox(height: heightScreen * 0.01),
            GestureDetector(
              onTap: () {
                controller.pickImage();
              },
              child: Obx(() {
                return controller.selectedImages.isNotEmpty
                    ? GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: controller.selectedImages.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  controller.selectedImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: GestureDetector(
                                  onTap: () => controller.removeImage(index),
                                  child: Icon(
                                    Icons.close_outlined,
                                    color: AppColor.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Container(
                        height: heightScreen * 0.1,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.5, color: AppColor.blue500),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Tambah Foto",
                          style: AppTextStyle.tsNormal,
                        ),
                      );
              }),
            ),

            spaceHeightSmall,
            Text(
              "Kirim Laporan untuk",
              style: AppTextStyle.tsTitle,
            ),
            spaceHeightSmall,
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.students.isEmpty) {
                return Center(child: Text("Tidak ada murid"));
              } else {
                return Container(
                  child: ListView.builder(
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
                          child: Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Container(
                                  margin: EdgeInsets.only(right: 12),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: selected.value
                                                  ? Border.all(
                                                      width: 2,
                                                      color: AppColor.blue800)
                                                  : null),
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: AppColor.blue200,
                                              child: CircleAvatar(
                                                child: Image.network(
                                                  student.photo == null
                                                      ? 'https://ui-avatars.com/api/?name=${student.name}&background=C1CDFF'
                                                      : student.photo!,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        SizedBox(height: 10),
                                        AutoSizeText(
                                          student.name!,
                                          style: AppTextStyle.tsSmallRegular(
                                              AppColor.black),
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          )),
                        );
                      }),
                );
              }
            }),
            SizedBox(height: heightScreen * 0.03),
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
