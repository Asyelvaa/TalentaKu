import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/dal/services/api_user.dart';
import '../../../infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  final ApiServiceUser apiService = ApiServiceUser();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  var isAuth = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    // autoLogin();
    // login();
    super.onInit();
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> autoLogin() async {
    final box = GetStorage();
    if(box.read("token")) {
      final dataUser = box.read("dataUser") as Map<String, dynamic>;
      final token = dataUser["token"];
      if(token != null) {
        isAuth.value = true;
        Get.offAllNamed(Routes.HOME_PAGE);
      } 
    }
  }

  Future<void> login() async {
    isLoading.value = true;

    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      dialogError('Email dan Password tidak boleh kosong');
      isLoading.value = false;
      return;
    }
    // print(email);
    // print(password);
    try {
      final response = await apiService.login(email, password);
      if (response['success']) {
        final data = response['data'];  
        final token = response['token'];
        box.write('dataUser', {
          'email': email,
          'password': password,
          'username': data['name'],
          'id': data['id'],
          'role': List<String>.from(data['roles']),
        } );
        box.write('token', token);
        isAuth.value = true;
        Map<String, dynamic>? dataUser = box.read('dataUser');
        print(dataUser);
        Get.offAllNamed(Routes.PICK_IMAGE);
      }
    } catch (e) {
      dialogError('Pengguna tidak terdaftar');
      print(e);
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
