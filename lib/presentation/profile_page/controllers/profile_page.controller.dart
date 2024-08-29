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
    print(' init user : ${currentUser.value.name}');
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      var data = await apiService.getUserData();
      currentUser.value = data;
      print('User data: ${currentUser.value.name}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePassword(String currentPassword, String newPassword, String newPasswordConfirmation) async {
  try {
    isLoading.value = true;

    Map<String, dynamic> body = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };

    final response = await apiService.updatePassword(body);

    if (response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Password updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final errorData = json.decode(response.body);
      Get.snackbar(
        'Update Failed',
        errorData['message'] ?? 'An error occurred while updating the password.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    print('Error: $e');
    Get.snackbar(
      'Update Failed',
      'An error occurred while updating the password. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
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
