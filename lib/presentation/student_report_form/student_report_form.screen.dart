import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

import 'component/form.dart';
import 'controllers/student_report_form.controller.dart';

class StudentReportFormScreen extends GetView<StudentReportFormController> {
  const StudentReportFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Handle back navigation
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
            // Date input fields
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
                  child: TextFormField(
                    controller: controller.createdController,
                    decoration: InputDecoration(
                      labelText: "DD/MM/YYYY",
                      hintStyle: AppTextStyle.tsLittle,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            // Kegiatan Awal section
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
              pointType: 'Kurang', // Contoh penggunaan pointType
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
              pointType: 'Belum Muncul', // Contoh penggunaan pointType
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
              pointType: 'Muncul', // Contoh penggunaan pointType
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
            // Media (foto/vidio)
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
                      : Text(
                          "+ Foto / Vidio Baru",
                          style: AppTextStyle.tsNormal,
                        ),
                );
              }),
            ),
            SizedBox(height: heightScreen * 0.02),
            // Select students section
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
              }
              return Wrap(
                spacing: 10,
                children: controller.students.map((student) {
                  final isSelected =
                      controller.selectedStudents.contains(student);
                  return GestureDetector(
                    onTap: () => controller.toggleSelection(student),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: student.photo != null
                              ? NetworkImage(student.photo!)
                              : AssetImage('assets/images/anak.png')
                                  as ImageProvider,
                          backgroundColor:
                              isSelected ? Colors.blue : Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(student.name),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
            SizedBox(height: heightScreen * 0.03),
            GestureDetector(
              onTap: () {
                int studentId = controller.selectedStudents.first.id;
                controller.submitReport(
                  created: controller.createdController.text
                      .replaceAll(RegExp(r'/'), '-'),
                  semesterId: int.parse(controller.semesterIdController.text),
                  kegiatanAwal: controller.kegiatanIntiTextController.text,
                  awalPoint: controller.selectedOptions['Kegiatan Awal']!,
                  kegiatanInti: controller.kegiatanIntiTextController.text,
                  intiPoint: controller.selectedOptions['Kegiatan Inti']!,
                  snack: controller.SnackTextController.text,
                  snackPoint: controller.selectedOptions['Snack']!,
                  inklusi: controller.inklusiTextController.text,
                  inklusiPoint: controller.selectedOptions['Inklusi']!,
                  catatan: controller.catatanController.text,
                  media: [
                    controller.selectedImage.value!,
                  ],
                  studentId: studentId,
                );
              },
              child: Container(
                height: heightScreen * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.blue100,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    "Kirim Laporan",
                    style: AppTextStyle.tsNormal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
