import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/models/class_model.dart';
import '../../../domain/models/user_model.dart';
import '../../profile_page/controllers/profile_page.controller.dart';

class ClassController extends GetxController {

  final TextEditingController classNameController = TextEditingController();
  final TextEditingController teacherNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController(); 

  var classes = <ClassModel>[].obs;
  var joinedClasses = <ClassModel>[].obs;
  var archivedClasses = <ClassModel>[].obs;

  late final ProfilePageController userController;
  var currentUser = UserModel(
    id: 0,
    name: '',
    email: '',
    emailVerifiedAt: '',
    nomorInduk: '',
    address: '',
    birthDate: '',
    createdAt: '',
    updatedAt: '',
    roles: [],
    grades: '',
  ).obs;
  
  List<ClassModel> mockupGrades = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    userController = Get.put(ProfilePageController());
    userController.fetchUser().then((value) {
      currentUser.value = userController.user.value;
      mockupGrades = [
        ClassModel(
          id: '1',
          name: 'Kelompok Gajah',
          teacher: currentUser.value.name,
          description: 'Kelas KB',
          isActive: true,
        ),
        ClassModel(
          id: '2',
          name: 'Kelas Singa',
          teacher: currentUser.value.name,
          description: 'Kelas SD',
          isActive: false,
        ),
      ];
      
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void addClass(String name, String teacher, String description, bool isActive) {
    String newClassId = (classes.length + 1).toString();
    ClassModel newClass = ClassModel(
      id: newClassId,
      name: name,
      teacher: teacher,
      description: description,
      isActive: isActive
    );
    classes.add(newClass);
  }

  void joinClass(String classCode) {
    ClassModel? classToJoin = classes.firstWhereOrNull((cls) => cls.id == classCode);
    if (classToJoin != null && !joinedClasses.contains(classToJoin)) {
      joinedClasses.add(classToJoin);
    } else {
      Get.snackbar('Error', 'Class not found or already joined');
    }
  }
}
