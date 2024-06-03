import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Gagagl','Email dan Password tidak boleh kosong');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://talentaku.site/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final bool success = responseData['success'];
        if (success) {
          // Get.toNamed(Routes.);
        } else {
          final String errorMessage = responseData['message'] ?? 'Login gagal';
          Get.snackbar('Error', errorMessage);
        }
      } else {
        print('Gagal untuk login. Status code: ${response.statusCode}');
        Get.snackbar(
            'Error', 'Gagagl untuk login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during login: $error');
      Get.snackbar('Error', 'An error occurred during login');
    } finally {
      isLoading.value = false;
    }
  }
}
