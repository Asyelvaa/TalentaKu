import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              children: [
                Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppColor.blue500),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: GestureDetector(
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
                                      color: AppColor.background),
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

            Text(
              "Kegiatan Awal",
              style: AppTextStyle.tsTitle,
            ),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.kegiatanAwalTextController,
              controller: controller,
              sectionTitle: "Kegiatan Awal",
              pointType: 'Muncul', // Contoh penggunaan pointType
            ),
            SizedBox(height: heightScreen * 0.02),
            // Kegiatan Inti section
            Text(
              "Kegiatan Inti",
              style: AppTextStyle.tsTitle,
            ),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.kegiatanIntiTextController,
              controller: controller,
              sectionTitle: "Kegiatan Inti",
              pointType: 'Kurang',
            ),
            SizedBox(height: heightScreen * 0.02),
            // Snack section
            Text(
              "Snack",
              style: AppTextStyle.tsTitle,
            ),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.SnackTextController,
              controller: controller,
              sectionTitle: "Snack",
              pointType: 'Belum Muncul',
            ),
            SizedBox(height: heightScreen * 0.02),
            // Inklusi section
            Text(
              "Inklusi",
              style: AppTextStyle.tsTitle,
            ),
            SizedBox(height: heightScreen * 0.02),
            FormSection(
              textController: controller.inklusiTextController,
              controller: controller,
              sectionTitle: "Inklusi",
              pointType: 'Muncul',
            ),
            SizedBox(height: heightScreen * 0.02),
            // Catatan section
            Text(
              "Catatan",
              style: AppTextStyle.tsTitle,
            ),
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
                onChanged: (value) {
                  // Update catatan in the controller
                  // Example: controller.catatan = value;
                },
              ),
            ),
            SizedBox(height: heightScreen * 0.02),
            Row(
              children: [
                Icon(
                  Iconsax.document_upload,
                  color: AppColor.blue400,
                ),
                SizedBox(width: widthScreen * 0.02),
                Text(
                  "Upload Tugas Kamu :",
                  style: AppTextStyle.tsNormal
                      .copyWith(fontWeight: FontWeight.bold),
                )
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
                                    Icons.remove_circle,
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
                          "+ Foto / Vidio Baru",
                          style: AppTextStyle.tsNormal,
                        ),
                      );
              }),
            ),

            SizedBox(height: heightScreen * 0.02),
            Text(
              "Kirim Laporan untuk",
              style: AppTextStyle.tsTitle,
            ),
            SizedBox(height: heightScreen * 0.02),
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
                              child: Stack(
                            children: [
                              Column(
                                children: [
                                  Obx(
                                    () => Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: selected.value
                                              ? Border.all(
                                                  width: 2,
                                                  color: AppColor.blue800)
                                              : null),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: student.photo != null
                                            ? NetworkImage(student.photo!)
                                            : AssetImage(
                                                    'assets/images/anak.png')
                                                as ImageProvider,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(student.name!),
                                ],
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
                          if (controller.studentId != 0) {
                            controller.submitReport(
                              created: controller.createdController.text,
                              semesterId: int.parse(
                                  controller.semesterIdController.text),
                              kegiatanAwal:
                                  controller.kegiatanAwalTextController.text,
                              awalPoint:
                                  controller.selectedOptions['Kegiatan Awal']!,
                              kegiatanInti:
                                  controller.kegiatanIntiTextController.text,
                              intiPoint:
                                  controller.selectedOptions['Kegiatan Inti']!,
                              snack: controller.SnackTextController.text,
                              snackPoint: controller.selectedOptions['Snack']!,
                              inklusi: controller.inklusiTextController.text,
                              inklusiPoint:
                                  controller.selectedOptions['Inklusi']!,
                              catatan: controller.catatanController.text,
                              media: controller.selectedImages,
                              studentId: controller.studentId.value,
                            );
                          } else {
                            Get.snackbar('Peringatan', 'Harap pilih siswa',
                                backgroundColor: AppColor.red);
                          }
                        },
                  color: AppColor.blue100,
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
