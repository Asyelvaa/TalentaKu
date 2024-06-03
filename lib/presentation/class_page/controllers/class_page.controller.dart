import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile_page/model/user_model.dart';
import '../model/class_model.dart';

class ClassController extends GetxController {
  final TextEditingController classController = TextEditingController();

  var classes = <String>[].obs;
  var archivedClasses = <String>[].obs;
  var currentUser = mockUserList[0].obs;

  // void addClass(ClassModel newClass) {
  //   if (currentUser.value.role == 'teacher') {
  //     classes.add(newClass);
  //   }
  // }

  // void archiveClass(String className) {
  //   if (currentUser.value.role == 'teacher') {
  //     archivedClasses.add(className);
  //   }
  // }

  // void joinClass(ClassModel classToJoin) {
  //   if (currentUser.value.role == 'student') {
  //     classes.add(classToJoin);
  //   }
  // }

  // void editClass(int index, ClassModel updatedClass) {
  //   if (currentUser.value.role == 'teacher') {
  //     classes[index] = updatedClass;
  //   }
  // }

  final count = 0.obs;
  @override
  void onInit() {
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

  void increment() => count.value++;
}
