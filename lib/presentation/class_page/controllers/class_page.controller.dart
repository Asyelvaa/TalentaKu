
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/models/class_model.dart';
import '../../../infrastructure/dal/services/api_class.dart';
import '../../profile_page/controllers/profile_page.controller.dart';

class ClassController extends GetxController {

  final ApiServiceClass apiService = ApiServiceClass();
  final userController = Get.put(ProfilePageController());
  RxList<String> userRole = <String>[].obs;

  // RxList<GradeModel> gradeList = <GradeModel>[].obs;

  // RxList<GradeModel> get activeClasses => gradeList.where((classItem) => classItem.isactive.toLowerCase() == '1').toList().obs;
  // RxList<GradeModel> get inactiveClasses => gradeList.where((classItem) => classItem.isactive.toLowerCase() != '1').toList().obs;

  RxList<Map<String, dynamic>> gradeList = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get activeClasses => gradeList.where((classItem) => classItem['is_active_status'].toLowerCase() == 'active').toList();
  List<Map<String, dynamic>> get inactiveClasses => gradeList.where((classItem) => classItem['is_active_status'].toLowerCase() != 'active').toList();


  final classNameController = TextEditingController();
  final classDescController = TextEditingController(); 
  final classLevelController = TextEditingController(); 
  final classCodeController = TextEditingController(); 

  var isLoading = false.obs;

  @override
  void onInit() {
    print('token : ${GetStorage().read('token')}');
    fetchCurrentUserRole();
    showAllGrades();
    super.onInit();
  }

  // Current User
  void fetchCurrentUserRole() {
    final box = GetStorage();

    Map<String, dynamic>? dataUser = box.read('dataUser');
    if (dataUser != null) {
      userRole.value = List<String>.from(dataUser['role']);
      print(userRole);
    }
  }

  // Create
  Future<void> createNewClass() async {
    final name = classNameController.text;
    final desc = classDescController.text;
    final levelId = int.parse(classLevelController.text);

    if (name.isEmpty || desc.isEmpty || levelId == null) {
      print('All fields are required');
      return;
    }
    print('$name, $desc, $levelId');

    isLoading.value = true;
    try {
      final result = await apiService.createClass(name, desc, levelId);
      print(result);
      await showAllGrades();      
    } catch (e) {
      print('Error creating class: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Join
  Future<void> joinNewClass() async {
    final uniqueCode = classCodeController.text;
    if (uniqueCode.isEmpty) {
      print('Unique code is required');
      return;
    }

    isLoading.value = true;
    try {
      await apiService.joinClass(uniqueCode);
      await showAllGrades();      
    } catch (e) {
      print('Error joining class: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Show All teacher & Show All Student
  Future<void> showAllGrades() async {
     var grades;
    try {
      isLoading(true);
      fetchCurrentUserRole();
       if (userRole.any((role) => role.contains('Guru'))) {
        grades = await apiService.getGradesTeacher();
      } else if (userRole.any((role) => role.contains('Murid'))) {
        grades = await apiService.getGradesStudent();
      }
      
      if (grades != null) {
        gradeList.assignAll(grades);
      }
    } finally {
      isLoading(false);
    }
  }
}
