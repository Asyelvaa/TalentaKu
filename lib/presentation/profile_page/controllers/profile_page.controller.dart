import 'dart:convert';

import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/user_model.dart';
import '../../../infrastructure/dal/services/api_user.dart';
import '../../../infrastructure/navigation/routes.dart';

class ProfilePageController extends GetxController {
  
  final ApiServiceUser apiService = ApiServiceUser();
  final box = GetStorage();
  var isLoading = false.obs;
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    inituser();
  }

  Future<void> inituser() async {
    await getUserData();
    print(currentUser.value.name);
  }

  Future<void> getUserData() async  {
    try {
      isLoading.value = true;
      var data = await apiService.getUserData();
      currentUser.value = data;
      print('User data: ${currentUser.value.name}');
    } finally {
      isLoading.value = false;
    }
  } 

 Future<void> logout() async {
    try {
      await apiService.logout();
      Get.offAllNamed(Routes.LoginScreen);
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Logout Failed',
        'An error occurred while logging out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
