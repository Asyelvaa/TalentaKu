import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/dal/services/api_user.dart';
import '../../../infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  final ApiServiceUser apiService = ApiServiceUser();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  var isAuth = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    autoLogin();
    usernameController.text = 'ita';
    passwordController.text = 'ita12345';
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> autoLogin() async {
    final token = box.read("token");
    if (token != null) {
      final dataUser = box.read("dataUser") as Map<String, dynamic>?;
      if (dataUser != null) {
        final token = dataUser["token"];
        if (token != null) {
          isAuth.value = true;
          Get.offAllNamed(Routes.HOME_PAGE);
        }
      }
    }
  }

  Future<void> login() async {
    isLoading.value = true;

    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      dialogError('Username dan Password tidak boleh kosong');
      isLoading.value = false;
      return;
    }
    try {
      final response = await apiService.login(username, password);
      if (response['data'] != null) {
        final data = response['data'];
        final token = response['token'];
        box.write('dataUser', {
          'username': username,
          'password': password,
          'name': data['name'],
          'id': data['id'],
          'role': List<String>.from(data['roles']),
        });
        box.write('token', token);
        isAuth.value = true;
        Get.offAllNamed(Routes.PICK_IMAGE);
      } else {
        String message = response['message'] ?? 'Login failed';
        dialogError(message);
      }
    } catch (e) {
      print(e);
      dialogError('Pastikan akun anda telah terdaftar');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await apiService.logout();
      isAuth.value = false;
      Get.offAllNamed(Routes.LoginScreen);
    } catch (e) {
      dialogError('Logout failed');
      print(e);
    }
  }

  void dialogError(String message) {
    Get.snackbar(
      'Gagal',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }
}
