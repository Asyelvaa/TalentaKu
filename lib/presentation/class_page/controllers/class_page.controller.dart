
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../domain/models/user_model.dart';
import '../../../infrastructure/dal/services/api_services.dart';

class ClassController extends GetxController {
  final ApiService apiService = ApiService();
  final classNameController = TextEditingController();
  final classDescController = TextEditingController();
  final classLevelController = TextEditingController();
  final classCodeController = TextEditingController();
  var isLoading = false.obs;

  // RxList<GradeModel> gradesList = <GradeModel>[].obs;
  RxString message = ''.obs;
  Rx<UserModel> currentUser = UserModel(
    id: 0,
    name: '',
    email: '',
    identificationNumber: '',
    address: '',
    birthInformation: '',
    photo: '',
    roles: [],
    grades: [],
  ).obs;

  var userRole = <String>[].obs;
  var gradeList = <Map<String, dynamic>>[].obs;
      


  @override
  void onInit() {
    fetchCurrentUser();
    fetchGrades();
    print(userRole);

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

  void fetchCurrentUser() {
    final box = GetStorage();

    Map<String, dynamic>? dataUser = box.read('dataUser');
    if (dataUser != null) {
      userRole.value = List<String>.from(dataUser['role']);
    }
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

  //  void fetchCurrentUser() async {
  //   final token = GetStorage().read('token');
  //   try {
  //     UserModel user = await apiService.getCurrentUser();
  //     currentUser.value = user;
  //     List<GradeModel> updatedGrades = [];
  //     for (var grade in user.grades) {
  //       final matchedGrade = gradesList.firstWhere(
  //         (element) => element.id == grade.id,
  //         orElse: () => grade,
  //       );
  //       updatedGrades.add(matchedGrade);
  //     }
  //     currentUser.update((val) {
  //       val?.grades = updatedGrades;
  //     });
  //   } catch (e) {
  //     print('Error fetching current user: $e');
  //   }
  // }

  Future<void> fetchGrades() async {
    var grades;
    try {
      isLoading(true);
      fetchCurrentUser();
      if (userRole.any((role) => role.contains('Guru'))) {
        grades = await ApiService().getGradesTeacher();
      } else if (userRole.any((role) => role.contains('Murid'))) {
        grades = await ApiService().getGradesStudent();
      }

      if (grades != null) {
        gradeList.assignAll(grades);
      }
    } finally {
      isLoading(false);
    }
  }

  // Future<void> fetchGrades() async {
  //   try {
  //     List<GradeModel> grades = await apiService.getGradesTeacher();
  //     gradesList.assignAll(grades);
  //     print('Grades: $grades');

  //     if (currentUser.value.id != 0) {
  //     List<GradeModel> updatedGrades = [];
  //     for (var grade in currentUser.value.grades) {
  //       final matchedGrade = gradesList.firstWhere(
  //         (element) => element.id == grade.id,
  //         orElse: () => grade,
  //       );
  //       updatedGrades.add(matchedGrade);
  //     }
  //     currentUser.update((val) {
  //       val?.grades = updatedGrades;
  //     });
  //   }

  //   } catch (e) {
  //     print('Error fetching grades: $e');
  //   }
  // }

  Future<void> createNewClass() async {
    final name = classNameController.text;
    final desc = classDescController.text;
    final levelId = int.parse(classLevelController.text);

    if (name.isEmpty || desc.isEmpty) {
      print('All fields are required');
      return;
    }
    print('$name, $desc, $levelId');

    isLoading.value = true;
    try {
      final result = await apiService.createClass(name, desc, levelId);
      print(result);
      await fetchGrades();
    } catch (e) {
      print('Error creating class: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> joinNewClass() async {
    final uniqueCode = classCodeController.text;
    if (uniqueCode.isEmpty) {
      print('Unique code is required');
      return;
    }

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
