import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import '../../profile_page/model/user_model.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final box = GetStorage();
  final user = UserModel(
    id: 0,
    name: '',
    email: '',
    emailVerifiedAt: '',
    nomorInduk: '',
    address: '',
    birthDate: '',
    photo: '',
    createdAt: '',
    updatedAt: '',
    roles: [],
    grades: '',
  ).obs;
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
      Get.snackbar('Gagal', 'Email dan Password tidak boleh kosong');
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final success = responseData['success'];

        if (success) {
          final userData = responseData['data'];
          box.write('username', userData['user']);
          box.write('token', responseData['token']);
          Get.offAllNamed(Routes.PICK_IMAGE);
        } else {
          final String errorMessage = responseData['message'] ?? 'Login gagal';
          Get.snackbar('Error', errorMessage);
        }
      } else {
        Get.snackbar('Error', 'Maaf NIS Anda tidak terdaftar di aplikasi ini');
      }
    } catch (error) {
      print('Error occurred during login: $error');
      Get.snackbar('Error', 'An error occurred during login');
    } finally {
      isLoading.value = false;
    }
  }
}
