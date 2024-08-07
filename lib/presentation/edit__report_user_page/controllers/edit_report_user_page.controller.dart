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
  final RxList<Student> students = <Student>[].obs;
  final String baseUrl = 'https://talentaku.site/api';

  final createdController = TextEditingController();
  final semesterIdController = TextEditingController();
  final kegiatanAwalTextController = TextEditingController();
  final kegiatanIntiTextController = TextEditingController();
  final SnackTextController = TextEditingController();
  final inklusiTextController = TextEditingController();
  final catatanController = TextEditingController();
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
          kegiatanAwalTextController.text = data['kegiatan_awal'][0] ?? '';
          kegiatanIntiTextController.text = data['kegiatan_inti'][0] ?? '';
          SnackTextController.text = data['snack'][0] ?? '';
          inklusiTextController.text = data['inklusi'][0] ?? '';
          catatanController.text = data['catatan'][0] ?? '';
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

  Future<void> fetchSemesterReportData() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
          Uri.parse('$baseUrl/grades/$gradeId/student-report/semester/1'),
          headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        semesterReportData.assignAll(jsonData['data']);

        if (semesterReportData.isNotEmpty) {
          var data = semesterReportData.first;
          createdController.text = data['created'] ?? '';
          semesterIdController.text = data['semester_id']?.toString() ?? '';
          kegiatanAwalTextController.text = data['kegiatan_awal'] ?? '';
          kegiatanIntiTextController.text = data['kegiatan_inti'] ?? '';
          SnackTextController.text = data['snack'] ?? '';
          inklusiTextController.text = data['inklusi'] ?? '';
          catatanController.text = data['catatan'] ?? '';
        }
      } else {
        print("Error fetching semester report data");
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void editReport({
    required String created,
    required int semesterId,
    required String kegiatanAwal,
    required String awalPoint,
    required String kegiatanInti,
    required String intiPoint,
    required String snack,
    required String snackPoint,
    required String inklusi,
    required String inklusiPoint,
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
        'kegiatan_awal': kegiatanAwal,
        'awal_point': awalPoint,
        'kegiatan_inti': kegiatanInti,
        'inti_point': intiPoint,
        'snack': snack,
        'snack_point': snackPoint,
        'inklusi': inklusi,
        'inklusi_point': inklusiPoint,
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

  void setValueText() {
    List kegiatanAwal = reportUser['kegiatan_awal'];
    List kegiatanInti = reportUser['kegiatan_inti'];
    List snack = reportUser['snack'];
    List inklusi = reportUser['inklusi'];
    List catatan = reportUser['catatan'];
    createdController.text = reportUser['created'] ?? '';
    semesterIdController.text = reportUser['semester_id']?.toString() ?? '';
    kegiatanAwalTextController.text = kegiatanAwal[0] ?? '';
    kegiatanIntiTextController.text = kegiatanInti[0] ?? '';
    SnackTextController.text = snack[0] ?? '';
    inklusiTextController.text = inklusi[0] ?? '';
    catatanController.text = catatan[0] ?? '';
  }

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
  void onInit() {
    arguments = Get.arguments;
    if (arguments[0] == 'edit') {
      reportUser.value = arguments[1];
      gradeId = arguments[1];
      print(reportUser);
      setValueText();
    } else {
      print('kontol2');
      fetchDataReport();
      fetchSemesterReportData();
      pickImage();
    }
    super.onInit();
  }
}
