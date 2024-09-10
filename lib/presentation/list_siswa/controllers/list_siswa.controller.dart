import 'dart:convert';

import 'package:flutter_talentaku/domain/models/class_member_model.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ListSiswaController extends GetxController {
  final studentId = 0.obs;
  late final String gradeId;
  late Map<String, dynamic> classItem;
  var username = ''.obs;
  var selectedOptions = <String, String>{}.obs;
  late List<String> userRole;
  RxList<String> selectedPoints = <String>[].obs;
  final box = GetStorage();
  final isLoading = false.obs;
  final RxList<ClassMemberModel> students = <ClassMemberModel>[].obs;
  final RxList<ClassMemberModel> selectedStudents = <ClassMemberModel>[].obs;
  RxList<RxBool> isSelected = RxList<RxBool>();

  void toggleSelection(ClassMemberModel student) {
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
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

  @override
  void onInit() {
    gradeId = Get.arguments["gradeId"];
    userRole = GetStorage().read('dataUser')['role'];
    username.value = GetStorage().read('dataUser')?['username'];
    classItem = Get.arguments as Map<String, dynamic>;
    print({username, userRole.toString()});
    print('id siswa: {$students}');
    fetchStudentsFromApi();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
