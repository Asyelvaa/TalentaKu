import 'dart:convert';
import 'dart:io';

import 'package:flutter_talentaku/domain/models/class_member_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../model/Student.dart';
import 'package:http_parser/http_parser.dart';

class StudentReportFormController extends GetxController {
  var selectedImage = Rxn<File>();
  RxList<File> selectedImages = <File>[].obs;
  final createdController = TextEditingController();
  final semesterIdController = TextEditingController();
  final catatanController = TextEditingController();
  final kegiatanAwalTextController = TextEditingController();
  final kegiatanIntiTextController = TextEditingController();
  final SnackTextController = TextEditingController();
  final inklusiTextController = TextEditingController();

  final studentId = 0.obs;
  late final String gradeId;
  var selectedOptions = <String, String>{}.obs;

  RxList<String> selectedPoints = <String>[].obs;
  final box = GetStorage();
    final isLoading = false.obs;
  final RxList<ClassMemberModel> students = <ClassMemberModel>[].obs;
  final RxList<ClassMemberModel> selectedStudents = <ClassMemberModel>[].obs;
  Rx<File?> image = Rx<File?>(null);

  RxList<RxBool> isSelected = RxList<RxBool>();

  void toggleSelection(ClassMemberModel student) {
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
  }

  @override
  void onInit() {
    super.onInit();
    gradeId = Get.arguments["gradeId"];
    fetchStudentsFromApi();
    _loadStoredImage();
  }

  void _loadStoredImage() {
    String? storedImagePath = box.read('profile_image_path');
    if (storedImagePath != null) {
      image.value = File(storedImagePath);
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void fetchStudentsFromApi() async {
    isLoading.value = true;
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = 'https://talentaku.site/api/grades/$gradeId';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> membersJson = jsonResponse['data']['members'];
        final List<ClassMemberModel> memberList = membersJson
            .map((memberJson) => ClassMemberModel.fromJson(memberJson))
            .toList();

        isSelected.value =
            List.generate(memberList.length, (index) => false.obs);
        students.assignAll(memberList);
        print("Fetched students data: ${students.length}");
      } else {
        Get.snackbar(
            'Error', 'Failed to fetch students: ${response.statusCode}',
            backgroundColor: AppColor.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred', backgroundColor: AppColor.red);
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
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
    if (created.isEmpty ||
        semesterId == 0 ||
        kegiatanAwal.isEmpty ||
        awalPoint.isEmpty ||
        kegiatanInti.isEmpty ||
        intiPoint.isEmpty ||
        snack.isEmpty ||
        snackPoint.isEmpty ||
        inklusi.isEmpty ||
        inklusiPoint.isEmpty ||
        catatan.isEmpty ||
        studentId == 0) {
      Get.snackbar(
        'Peringatan',
        'Harap isi semua kolom yang wajib diisi',
        backgroundColor: AppColor.red,
      );
      return;
    }

    try {
      final url = 'https://talentaku.site/api/grades/$gradeId/student-report';
      final token = box.read('token');
      print(url);
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
        'student_id': studentId
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
        Get.snackbar('Sukses', 'Laporan telah dikirim',
            backgroundColor: AppColor.blue100);
        Get.offAllNamed(Routes.NAVBAR);
        print(formData);
      } else {
        Get.snackbar('Error', 'Gagal mengirim laporan: ${response.statusCode}',
            backgroundColor: AppColor.red);
        print(await response.stream.bytesToString());
      }
    } catch (error) {
      print('Error occurred during report submission: $error');
      Get.snackbar('Error', 'Terjadi kesalahan', backgroundColor: AppColor.red);
    }

    isLoading.value = false;
  }
}
