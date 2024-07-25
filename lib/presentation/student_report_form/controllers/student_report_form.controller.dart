import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_storage/get_storage.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../model/Student.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class StudentReportFormController extends GetxController {
  var selectedImage = Rxn<File>();
  final createdController = TextEditingController();
  final semesterIdController = TextEditingController();
  final catatanController = TextEditingController();
  final kegiatanAwalTextController = TextEditingController();
  final kegiatanIntiTextController = TextEditingController();
  final SnackTextController = TextEditingController();
  final inklusiTextController = TextEditingController();

  var selectedOptions = <String, String>{}.obs;

  RxList<String> selectedPoints = <String>[].obs;
  final box = GetStorage();
  final RxBool isLoading = false.obs;
  final RxList<Student> students = <Student>[].obs;
  final RxList<Student> selectedStudents = <Student>[].obs;

  void toggleSelection(Student student) {
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchStudentsFromApi();
    pickImage();
  }

  void fetchStudentsFromApi() async {
    isLoading.value = true;
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = 'https://talentaku.site/api/grades/teacher';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> grades = jsonResponse['grades'];
        students.clear();

        for (var grade in grades) {
          if (grade['members'] != null) {
            final List<dynamic> members = grade['members'];
            students.addAll(
                members.map((member) => Student.fromJson(member)).toList());
          }
        }

        print("Fetched students data: ${students}");
      } else {
        Get.snackbar(
            'Error', 'Failed to fetch students: ${response.statusCode}',
            backgroundColor: AppColor.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred', backgroundColor: AppColor.red);
    } finally {
      isLoading.value = false;
    }
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

  void submitReport({
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
    required int studentId,
  }) async {
    try {
      final url = 'https://talentaku.site/api/grades/3/student-report';
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
        'student_id': 7,
      };

      final request = await http.MultipartRequest(
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
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Report has been submitted',
            backgroundColor: AppColor.blue100);
        Get.offAllNamed(Routes.HOME_PAGE);
        print(formData);
      } else {
        Get.snackbar('Error', 'Failed to submit report: ${response.statusCode}',
            backgroundColor: AppColor.red);
        print(await response.stream.bytesToString());
      }
    } catch (error) {
      print('Error occurred during report submission: $error');
      Get.snackbar('Error', 'An error occurred', backgroundColor: AppColor.red);
    }

    isLoading.value = false;
  }
}
