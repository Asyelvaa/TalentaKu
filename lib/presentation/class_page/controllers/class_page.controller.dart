import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile_page/controllers/profile_page.controller.dart';
import '../../profile_page/model/user_model.dart';

class ClassController extends GetxController {
  final TextEditingController classController = TextEditingController();

  var classes = <String>[].obs;
  var archivedClasses = <String>[].obs;

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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    userController = Get.put(ProfilePageController());
    userController.fetchUser().then((value) {
      currentUser.value = userController.user.value;
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

}
