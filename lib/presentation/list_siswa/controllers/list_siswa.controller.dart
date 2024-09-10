import 'dart:convert';

import 'package:flutter_talentaku/domain/models/class_member_model.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ListSiswaController extends GetxController {
  late final String gradeId;
  late List<String> userRole;
  // late Map<String, dynamic> classItem;
  var username = ''.obs;
  var selectedOptions = <String, String>{}.obs;
  RxList<String> selectedPoints = <String>[].obs;
  final box = GetStorage();
  final isLoading = false.obs;
  final studentId = 0.obs;
  // final RxList<ClassMemberModel> students = <ClassMemberModel>[].obs;
  // final RxList<ClassMemberModel> selectedStudents = <ClassMemberModel>[].obs;
  RxList<RxBool> isSelected = RxList<RxBool>();
  final students = <ClassMemberModel>[].obs;
  final selectedStudent = Rx<ClassMemberModel?>(null);

  void toggleSelection(ClassMemberModel student) {
    print("Current selected student: ${selectedStudent.value?.name}");
    if (selectedStudent.value == student) {
      selectedStudent.value = null; 
      // print("Deselected student: ${student.name}");
    } else {
      selectedStudent.value = student; 
      print("Selected student: ${student.name}");
    }
    // if (selectedStudents.contains(student)) {
    //   selectedStudents.remove(student);
    // } else {
    //   selectedStudents.add(student);
    // }
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
        students.assignAll(memberList);
        // isSelected.value =
        //     List.generate(memberList.length, (index) => false.obs);
        // students.assignAll(memberList);
        // print("Fetched students data: ${students.length}");
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
    Map<String, dynamic> arguments = Get.arguments;
    gradeId = arguments["gradeId"];
    print(gradeId);

    userRole = GetStorage().read('dataUser')['role'];
    username.value = GetStorage().read('dataUser')?['username'];
    print({username, userRole.toString()});

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
    selectedStudent.close();
    selectedOptions.close();
    selectedPoints.close();
    students.close();
    isSelected.clear();
  }
}
