import 'dart:convert';
import 'dart:io';

import 'package:flutter_talentaku/domain/models/class_member_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../model/Student.dart';

class StudentReportFormController extends GetxController {
  var selectedImage = Rxn<File>();
  RxList<File> selectedImages = <File>[].obs;
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
  final selectedDate = Rxn<DateTime>();

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

  void pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        selectedDate.value = value;
      }
    });
  }

  void _loadStoredImage() {
    String? storedImagePath = box.read('profile_image_path');
    if (storedImagePath != null) {
      image.value = File(storedImagePath);
    }
  }

  void removeImage(File file) {
    selectedImages.removeWhere((element) => element.path == file.path);
    // selectedImages.removeAt(index);
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
    print(selectedOptions);
  }

  void submitReport({
    required String created,
    required int semesterId,
    required String kegiatanAwalDihalaman,
    required String dihalamanHasil,
    required String kegiatanAwalBerdoa,
    required String berdoaHasil,
    required String kegiatanIntiSatu,
    required String intiSatuHasil,
    required String kegiatanIntiDua,
    required String intiDuaHasil,
    required String kegiatanIntiTiga,
    required String intiTigaHasil,
    required String snack,
    required String inklusi,
    required String inklusiHasil,
    required String inklusiPenutup,
    required String inklusiPenutupHasil,
    required String inklusiDoa,
    required String inklusiDoaHasil,
    required List<String> catatan,
    required List<File> media,
    required int studentId,
  }) async {
    // if (created.isEmpty ||
    //     semesterId == 0 ||
    //     kegiatanAwalDihalaman.isEmpty ||
    //     dihalamanHasil.isEmpty ||
    //     kegiatanAwalBerdoa.isEmpty ||
    //     berdoaHasil.isEmpty ||
    //     kegiatanIntiSatu.isEmpty ||
    //     intiSatuHasil.isEmpty ||
    //     kegiatanIntiDua.isEmpty ||
    //     intiDuaHasil.isEmpty ||
    //     kegiatanIntiTiga.isEmpty ||
    //     intiTigaHasil.isEmpty ||
    //     snack.isEmpty ||
    //     inklusi.isEmpty ||
    //     inklusiHasil.isEmpty ||
    //     inklusiPenutup.isEmpty ||
    //     inklusiPenutupHasil.isEmpty ||
    //     inklusiDoa.isEmpty ||
    //     inklusiDoaHasil.isEmpty ||
    //     catatan.isEmpty ||
    //     studentId == 0) {
    //   Get.snackbar(
    //     'Peringatan',
    //     'Harap isi semua kolom yang wajib diisi',
    //     backgroundColor: AppColor.red,
    //   );
    //   return;
    // }

    try {
      final url = 'https://talentaku.site/api/grades/$gradeId/student-report';
      final token = box.read('token');
      print(url);

      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields['created'] = created
        ..fields['semester_id'] = semesterId.toString()
        ..fields['kegiatan_awal_dihalaman'] = kegiatanAwalDihalaman
        ..fields['dihalaman_hasil'] = dihalamanHasil
        ..fields['kegiatan_awal_berdoa'] = kegiatanAwalBerdoa
        ..fields['berdoa_hasil'] = berdoaHasil
        ..fields['kegiatan_inti_satu'] = kegiatanIntiSatu
        ..fields['inti_satu_hasil'] = intiSatuHasil
        ..fields['kegiatan_inti_dua'] = kegiatanIntiDua
        ..fields['inti_dua_hasil'] = intiDuaHasil
        ..fields['kegiatan_inti_tiga'] = kegiatanIntiTiga
        ..fields['inti_tiga_hasil'] = intiTigaHasil
        ..fields['snack'] = snack
        ..fields['inklusi'] = inklusi
        ..fields['inklusi_hasil'] = inklusiHasil
        ..fields['inklusi_penutup'] = inklusiPenutup
        ..fields['inklusi_penutup_hasil'] = inklusiPenutupHasil
        ..fields['inklusi_doa'] = inklusiDoa
        ..fields['inklusi_doa_hasil'] = inklusiDoaHasil
        ..fields['catatan'] = catatan.join(',')
        ..fields['student_id'] = studentId.toString();

      for (File file in media) {
        if (await file.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
            'media[]', // Ensure this matches the API's expected parameter name
            file.path,
            contentType: MediaType('image', 'jpeg'), // Adjust as necessary
          ));
        }
      }
      print(request.fields);
      final response = await request.send();
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Sukses', 'Laporan telah dikirim',
            backgroundColor: AppColor.blue100);
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
