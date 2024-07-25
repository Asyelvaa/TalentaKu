import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/dal/services/api_services.dart';
import '../../../infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  var isAuth = false.obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> autoLogin() async {
    final box = GetStorage();
    if(box.read("token") != null) {
      final dataUser = box.read("dataUser") as Map<String, dynamic>;
      final token = dataUser["token"];
      if(token != null) {
        // use token to verify auto-login 
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

    try {
      final response = await apiService.login(email, password);
      if (response['success']) {
        final data = response['data'];
        final token = response['token'];
        box.write(
          'dataUser', {
            'email': email,
            'password': password,
            'username': data['user'],
            'id' : data['id'],
            'role': List<String>.from(data['role']),
          }
        );
        box.write('token', token);
        Map<String, dynamic>? dataUser = box.read('dataUser');
        print(dataUser);
        print(token);
        Get.offAllNamed(Routes.PICK_IMAGE);
      }
    } catch (e) {
      dialogError('Pengguna tidak terdaftar');
    } finally {
      isLoading.value = false;
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
