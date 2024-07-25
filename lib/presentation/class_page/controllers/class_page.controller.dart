import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/models/class_model.dart';
import '../../../domain/models/user_model.dart';
import '../../../infrastructure/dal/services/api_services.dart';

class ClassController extends GetxController {
  final ApiService apiService = ApiService();
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classDescController = TextEditingController(); 
  final TextEditingController classLevelController = TextEditingController(); 
  final TextEditingController classCodeController = TextEditingController(); 
  var isLoading = false.obs;

  RxList<GradeModel> gradesList = <GradeModel>[].obs;
  RxString message = ''.obs;
  Rx<UserModel> currentUser = UserModel(
    id: 0,
    name: '',
    email: '',
    identificationNumber: '',
    address: '',
    birthDate: '',
    photo: '',
    roles: [],
    grades: [],
  ).obs;

  @override
  void onInit() {
    // fetchCurrentUser();
    fetchGrades();
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

  // var currentUser = Rxn<UserModel>();
  // final UserService userService = UserService();
  // Future<void> fetchCurrentUser() async {
  //   isLoading.value = true;
  //   final token = GetStorage().read('token');

  //   try {
  //     if (token != null) {
  //       final user = await apiService.getCurrentUser(token);
  //       userData.value = user;
  //       await userService.saveUser(user);
  //     } else {
  //       throw Exception('No token found');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  // void loadUserFromStorage() {
  //   userData.value = userService.getUser();
  // }

   void fetchCurrentUser() async {
    // final token = GetStorage().read('token');
    try {
      UserModel user = await apiService.getCurrentUser();
      currentUser.value = user;

      List<GradeModel> updatedGrades = [];
      for (var grade in user.grades) {
        final matchedGrade = gradesList.firstWhere(
          (element) => element.id == grade.id,
          orElse: () => grade,
        );
        updatedGrades.add(matchedGrade);
      }
      currentUser.update((val) {
        val?.grades = updatedGrades;
      });
    } catch (e) {
      print('Error fetching current user: $e');
    }
  }

  Future<void> fetchGrades() async {
    try {
      List<GradeModel> grades = await apiService.getGradesTeacher();
      gradesList.assignAll(grades);
      print('Grades: $grades');

      if (currentUser.value.id != 0) {
      List<GradeModel> updatedGrades = [];
      for (var grade in currentUser.value.grades) {
        final matchedGrade = gradesList.firstWhere(
          (element) => element.id == grade.id,
          orElse: () => grade,
        );
        updatedGrades.add(matchedGrade);
      }
      currentUser.update((val) {
        val?.grades = updatedGrades;
      });
    }

    } catch (e) {
      print('Error fetching grades: $e');
    }
  }

  Future<void> createNewClass(Map<String, dynamic> classData) async {
    isLoading.value = true;
    try {
      final result = await apiService.createClass(classData);
      print(result);
      await fetchGrades();
      
    } catch (e) {
      print('Error creating class: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // GABISA BEJIR
  Future<void> joinNewClass(String uniqueCode) async {
    isLoading.value = true;
    try {
      final result = await apiService.joinClass(uniqueCode);
      await fetchGrades();
      
    } catch (e) {
      print('Error joining class: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
