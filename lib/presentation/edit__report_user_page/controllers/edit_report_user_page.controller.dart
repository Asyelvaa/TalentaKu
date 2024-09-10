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
  late final reportId;
  late final gradeId;
  late final studentId;
  final box = GetStorage();
  var isLoading = false.obs;
  var reportData = [].obs;
  var semesterReportData = [].obs;

  final String baseUrl = 'https://talentaku.site/api';
  final kegiatan_awal_dihalamanTextController = TextEditingController();
  final kegiatan_awal_berdoaTextController = TextEditingController();
  final kegiatan_inti_satuTextController = TextEditingController();
  final kegiatan_inti_duaTextController = TextEditingController();
  final kegiatan_inti_tigaTextController = TextEditingController();
  final SnackTextController = TextEditingController();
  final inklusiTextController = TextEditingController();
  final inklusi_penutupTextController = TextEditingController();
  final inklusi_doaTextController = TextEditingController();
  final catatanController = TextEditingController();

  final reportUser = {}.obs;
  var selectedOptions = <String, String>{}.obs;
  var selectedImage = Rxn<File>();

  // Future<void> fetchDataReport() async {
  //   isLoading.value = true;
  //   final token = box.read('token');
  //   print(studentId);
  //   if (studentId == null || studentId.isEmpty) {
  //     print("Error: studentId is null or empty");
  //     isLoading.value = false;
  //     return;
  //   }
  //   final url = '$baseUrl/grades/$gradeId/student-report/student/$studentId';
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   print(url);
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       reportData.assignAll(jsonData['data']);
  //       if (reportData.isNotEmpty) {
  //         // var data = reportData[2];
  //         var data = reportData.firstWhere(
  //           (item) => item['id'] == reportId,
  //           orElse: () => null,
  //         );
  //         kegiatan_awal_dihalamanTextController.text =
  //             data['kegiatan_awal_dihalaman'][0] ?? '';
  //         selectedOptions['kegiatan_awal_dihalaman'] = data['dihalaman_hasil'];
  //         kegiatan_awal_berdoaTextController.text =
  //             data['kegiatan_awal_berdoa'][0] ?? '';
  //         selectedOptions['kegiatan_awal_berdoa'] = data['berdoa_hasil'];
  //         kegiatan_inti_satuTextController.text =
  //             data['kegiatan_inti_satu'][0] ?? '';
  //         selectedOptions['kegiatan_inti_satu'] = data['inti_satu_hasil'];
  //         kegiatan_inti_duaTextController.text =
  //             data['kegiatan_inti_dua'][0] ?? '';
  //         selectedOptions['kegiatan_inti_dua'] = data['inti_dua_hasil'];
  //         kegiatan_inti_tigaTextController.text =
  //             data['kegiatan_inti_tiga'][0] ?? '';
  //         selectedOptions['kegiatan_inti_tiga'] = data['inti_tiga_hasil'];
  //         SnackTextController.text = data['snack'][0] ?? '';
  //         inklusiTextController.text = data['inklusi'][0] ?? '';
  //         selectedOptions['inklusi'] = data['inklusi_hasil'];
  //         inklusi_doaTextController.text = data['inklusi_doa'][0] ?? '';
  //         selectedOptions['inklusi_doa'] = data['inklusi_doa_hasil'];
  //         inklusi_penutupTextController.text = data['inklusi_penutup'][0] ?? '';
  //         selectedOptions['inklusi_penutup'] = data['inklusi_penutup_hasil'];
  //         catatanController.text = data['catatan'][0] ?? '';
  //         print(data);
  //       }
  //     } else {
  //       print("Error fetching student report data ");
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  void initializeReportData() {
    var data = reportUser.value;

    kegiatan_awal_dihalamanTextController.text =
        data['kegiatan_awal_dihalaman']?.isNotEmpty == true
            ? data['kegiatan_awal_dihalaman'][0]
            : '';
    selectedOptions['kegiatan_awal_dihalaman'] = data['dihalaman_hasil'] ?? '';

    kegiatan_awal_berdoaTextController.text =
        data['kegiatan_awal_berdoa']?.isNotEmpty == true
            ? data['kegiatan_awal_berdoa'][0]
            : '';
    selectedOptions['kegiatan_awal_berdoa'] = data['berdoa_hasil'] ?? '';

    kegiatan_inti_satuTextController.text =
        data['kegiatan_inti_satu']?.isNotEmpty == true
            ? data['kegiatan_inti_satu'][0]
            : '';
    selectedOptions['kegiatan_inti_satu'] = data['inti_satu_hasil'] ?? '';

    kegiatan_inti_duaTextController.text =
        data['kegiatan_inti_dua']?.isNotEmpty == true
            ? data['kegiatan_inti_dua'][0]
            : '';
    selectedOptions['kegiatan_inti_dua'] = data['inti_dua_hasil'] ?? '';

    kegiatan_inti_tigaTextController.text =
        data['kegiatan_inti_tiga']?.isNotEmpty == true
            ? data['kegiatan_inti_tiga'][0]
            : '';
    selectedOptions['kegiatan_inti_tiga'] = data['inti_tiga_hasil'] ?? '';

    SnackTextController.text =
        data['snack']?.isNotEmpty == true ? data['snack'][0] : '';
    selectedOptions['snack'] = data['snack_hasil'] ?? '';

    inklusiTextController.text =
        data['inklusi']?.isNotEmpty == true ? data['inklusi'][0] : '';
    selectedOptions['inklusi'] = data['inklusi_hasil'] ?? '';

    inklusi_doaTextController.text =
        data['inklusi_doa']?.isNotEmpty == true ? data['inklusi_doa'][0] : '';
    selectedOptions['inklusi_doa'] = data['inklusi_doa_hasil'] ?? '';

    inklusi_penutupTextController.text =
        data['inklusi_penutup']?.isNotEmpty == true
            ? data['inklusi_penutup'][0]
            : '';
    selectedOptions['inklusi_penutup'] = data['inklusi_penutup_hasil'] ?? '';

    catatanController.text =
        data['catatan']?.isNotEmpty == true ? data['catatan'][0] : '';

    // Handle image if present
    // var media = data['media'] as List<dynamic>? ?? [];
    // if (media.isNotEmpty) {
    //   var filePath = media.first['file_path'];
    //   if (filePath != null) {
    //     selectedImage.value = File(filePath);
    //   }
    // }
  }

  Future<void> editReport({
    required String kegiatan_awal_dihalaman,
    required String dihalaman_hasil,
    required String kegiatan_awal_berdoa,
    required String berdoa_hasil,
    required String kegiatan_inti_satu,
    required String inti_satu_hasil,
    String? kegiatan_inti_dua,
    String? inti_dua_hasil,
    String? kegiatan_inti_tiga,
    String? inti_tiga_hasil,
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
    File? image,
  }) async {
    try {
      final url = '$baseUrl/grades/$gradeId/student-report/$reportId';
      final token = box.read('token');
      print(url);

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      var formData = {
        // 'created': reportUser.value[0]['created'],
        // 'semester_id': reportUser.value[0]['semester_id'],
        'created': reportUser.value != null
            ? reportUser.value['created'] 
            : '',
        'semester_id': reportUser.value != null
            ? reportUser.value['semester_id'] 
            : '',
        'kegiatan_awal_dihalaman': kegiatan_awal_dihalaman,
        'dihalaman_hasil': dihalaman_hasil,
        'kegiatan_awal_berdoa': kegiatan_awal_berdoa,
        'berdoa_hasil': berdoa_hasil,
        'kegiatan_inti_satu': kegiatan_inti_satu,
        'inti_satu_hasil': inti_satu_hasil,
        if (kegiatan_inti_dua != null) 'kegiatan_inti_dua': kegiatan_inti_dua,
        if (inti_dua_hasil != null) 'inti_dua_hasil': inti_dua_hasil,
        if (kegiatan_inti_tiga != null)
          'kegiatan_inti_tiga': kegiatan_inti_tiga,
        if (inti_tiga_hasil != null) 'inti_tiga_hasil': inti_tiga_hasil,
        'snack': snack,
        'inklusi': inklusi,
        'inklusi_hasil': inklusi_hasil,
        'inklusi_penutup': inklusi_penutup,
        'inklusi_penutup_hasil': inklusi_penutup_hasil,
        'inklusi_doa': inklusi_doa,
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
      print('idhjhfkdhfkd : ${response.statusCode}');
      if (response.statusCode == 200) {
        update();
        Get.back();
        Get.snackbar('Success', 'Report has been updated',
            backgroundColor: AppColor.blue100);

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

  Future<void> deleteReport(int reportId) async {
    final url = '$baseUrl/grades/$gradeId/student-report/$reportId';
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
        // fetchDataReport();
        Get.back(result: 'success');
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
    kegiatan_awal_dihalamanTextController.dispose();
    kegiatan_awal_berdoaTextController.dispose();
    kegiatan_inti_satuTextController.dispose();
    kegiatan_inti_duaTextController.dispose();
    kegiatan_inti_tigaTextController.dispose();
    SnackTextController.dispose();
    inklusiTextController.dispose();
    inklusi_penutupTextController.dispose();
    inklusi_doaTextController.dispose();
    catatanController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments[1]);
    if (arguments != null && arguments[0] == 'edit') {
      reportUser.value = arguments[1];
      gradeId = arguments[1]['grade_id'];
      studentId = arguments[1]['student_id'];
      reportId = arguments[1]['id'];
    }
    print(gradeId);
    print(reportId);
    print(studentId);
    initializeReportData();
    // fetchDataReport();
  }
}
