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

import '../../../infrastructure/theme/theme.dart';

class EditReportUserPageController extends GetxController {
  var isLoading = false.obs;
  late final arguments;
  late final gradeId;
  final box = GetStorage();
  var reportData = [].obs;
  var semesterReportData = [].obs;
  // final RxList<Student> students = <Student>[].obs;
  final String baseUrl = 'https://talentaku.site/api';
  final createdController = TextEditingController();
  final semesterIdController = TextEditingController();
  final kegiatan_awal_dihalamanTextController = TextEditingController();
  final kegiatan_awal_berdoaTextController = TextEditingController();
  final catatanController = TextEditingController();
  final kegiatanAwalTextController = TextEditingController();
  final kegiatan_inti_satuTextController = TextEditingController();
  final kegiatan_inti_duaTextController = TextEditingController();
  final kegiatan_inti_tigaTextController = TextEditingController();
  final SnackTextController = TextEditingController();
  final inklusiTextController = TextEditingController();
  final inklusi_penutupTextController = TextEditingController();
  final inklusi_doaTextController = TextEditingController();
  final RxList<Student> selectedStudents = <Student>[].obs;
  final reportUser = {}.obs;
  var selectedOptions = <String, String>{}.obs;
  var selectedImage = Rxn<File>();

  void toggleSelection(Student student) {
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
  }

  Future<void> fetchDataReport() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
          Uri.parse('$baseUrl/grades/$gradeId/student-report/student/7'),
          headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        reportData.assignAll(jsonData['data']);

        if (reportData.isNotEmpty) {
          var data = reportData.first;
          createdController.text = data['created'] ?? '';
          semesterIdController.text = data['semester_id']?.toString() ?? '';
          kegiatan_awal_dihalamanTextController.text =
              data['kegiatan_awal_dihalaman'][0] ?? '';
          kegiatan_awal_berdoaTextController.text =
              data['kegiatan_awal_berdoa'][0] ?? '';
          kegiatan_inti_satuTextController.text =
              data['kegiatan_inti_satu'][0] ?? '';
          kegiatan_inti_duaTextController.text =
              data['kegiatan_inti_dua'][0] ?? '';
          kegiatan_inti_tigaTextController.text =
              data['kegiatan_inti_tiga'][0] ?? '';
          SnackTextController.text = data['snack'][0] ?? '';
          inklusiTextController.text = data['inklusi'][0] ?? '';
          inklusi_doaTextController.text = data['inklusi_doa'][0] ?? '';
          inklusi_penutupTextController.text = data['inklusi_penutup'][0] ?? '';
          catatanController.text = data['catatan'][0] ?? '';

          print('halo beg0 : ${kegiatan_awal_dihalamanTextController.text}');
        }
      } else {
        print("Error fetching student report data");
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchSemesterReportData() async {
  //   isLoading.value = true;
  //   final token = box.read('token');

  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };

  //   try {
  //     final response = await http.get(
  //         Uri.parse('$baseUrl/grades/$gradeId/student-report/semester/1'),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       semesterReportData.assignAll(jsonData['data']);

  //       if (semesterReportData.isNotEmpty) {
  //         var data = semesterReportData.first;
  //         createdController.text = data['created'] ?? '';
  //         semesterIdController.text = data['semester_id']?.toString() ?? '';
  //         kegiatanAwalTextController.text = data['kegiatan_awal'] ?? '';
  //         kegiatanIntiTextController.text = data['kegiatan_inti'] ?? '';
  //         SnackTextController.text = data['snack'] ?? '';
  //         inklusiTextController.text = data['inklusi'] ?? '';
  //         catatanController.text = data['catatan'] ?? '';
  //       }
  //     } else {
  //       print("Error fetching semester report data");
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void editReport({
    required String created,
    required int semesterId,
    required String kegiatan_awal_dihalaman,
    required String dihalaman_hasil,
    required String kegiatan_awal_berdoa,
    required String berdoa_hasil,
    required String kegiatan_inti_satu,
    required String inti_satu_hasil,
    required String kegiatan_inti_dua,
    required String inti_dua_hasil,
    required String kegiatan_inti_tiga,
    required String inti_tiga_hasil,
    required String snack,
    required String inklusi,
    required String inklusi_hasil,
    required String inklusi_penutup,
    required String inklusi_penutup_hasil,
    required String inklusi_doa,
    required String doa_hasil,
    required String catatan,
    required List<File> media,
    required int reportId,
  }) async {
    try {
      final url =
          '$baseUrl/grades/${gradeId['grade_id']}/student-report/$reportId';
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      var formData = {
        'created': created,
        'semester_id': semesterId.toString(),
        'kegiatan_awal_dihalaman': kegiatan_awal_dihalamanTextController,
        'dihalaman_hasil': dihalaman_hasil,
        'kegiatan_awal_berdoa': kegiatan_awal_berdoaTextController,
        'berdoa_hasil': berdoa_hasil,
        'kegiatan_inti_satu': kegiatan_inti_satuTextController,
        'inti_satu_hasil': inti_satu_hasil,
        'kegiatan_inti_dua': kegiatan_inti_duaTextController,
        'inti_dua_hasil': inti_dua_hasil,
        'kegiatan_inti_tiga': kegiatan_inti_tigaTextController,
        'inti_tiga_hasil': inti_tiga_hasil,
        'snack': snack,
        'inklusi': inklusi,
        'inklusi_hasil': inklusi_hasil,
        'inklusi_penutup': inklusi_penutup,
        'inklusi_penutup_hasil': inklusi_penutup_hasil,
        'inklusi_doa': inklusi_doaTextController,
        'inklusi_doa_hasil': doa_hasil,
        'catatan': catatan,
        'student_id': box.read('student_id')
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.headers.addAll(headers);
      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      for (File file in media) {
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
              contentType: MediaType('application', 'octet-stream'),
            ),
          );
        }
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Report has been updated',
            backgroundColor: AppColor.blue100);
        Get.offAllNamed(Routes.REPORT_LIST_USER_PAGE);
        print(formData);
      } else {
        Get.snackbar('Error', 'Failed to update report: ${response.statusCode}',
            backgroundColor: AppColor.red);
        print(await response.stream.bytesToString());
      }
    } catch (error) {
      print('Error occurred during report update: $error');
      Get.snackbar('Error', 'An error occurred', backgroundColor: AppColor.red);
    }

    isLoading.value = false;
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void select(String sectionTitle, String option) {
    selectedOptions[sectionTitle] = option;
  }

  // void setValueText() {
  //   List kegiatanAwal = reportUser['kegiatan_awal'];
  //   List kegiatanInti = reportUser['kegiatan_inti'];
  //   List snack = reportUser['snack'];
  //   List inklusi = reportUser['inklusi'];
  //   List catatan = reportUser['catatan'];
  //   createdController.text = reportUser['created'] ?? '';
  //   semesterIdController.text = reportUser['semester_id']?.toString() ?? '';
  //   kegiatanAwalTextController.text = kegiatanAwal[0] ?? '';
  //   kegiatanIntiTextController.text = kegiatanInti[0] ?? '';
  //   SnackTextController.text = snack[0] ?? '';
  //   inklusiTextController.text = inklusi[0] ?? '';
  //   catatanController.text = catatan[0] ?? '';
  // }

  Future<void> deleteReport(int reportId) async {
    final url =
        '$baseUrl/grades/${gradeId['grade_id']}/student-report/$reportId';
    print(url);
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Report has been deleted',
            backgroundColor: AppColor.blue100);
      } else {
        Get.snackbar('Error', 'Failed to delete report: ${response.statusCode}',
            backgroundColor: AppColor.red);
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', 'An error occurred while deleting the report',
          backgroundColor: AppColor.red);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    createdController.dispose();
    semesterIdController.dispose();
    kegiatan_awal_dihalamanTextController.dispose();
    kegiatan_awal_berdoaTextController.dispose();
    catatanController.dispose();
    kegiatanAwalTextController.dispose();
    kegiatan_inti_satuTextController.dispose();
    kegiatan_inti_duaTextController.dispose();
    kegiatan_inti_tigaTextController.dispose();
    SnackTextController.dispose();
    inklusiTextController.dispose();
    inklusi_penutupTextController.dispose();
    inklusi_doaTextController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    arguments = Get.arguments;
    if (arguments[0] == 'edit') {
      fetchDataReport();
      reportUser.value = arguments[1];
      gradeId = arguments[1];
      print(gradeId);
      // setValueText();
      super.onInit();
    }
  }
}
