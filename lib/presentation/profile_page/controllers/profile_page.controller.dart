import 'dart:convert';

import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/user_model.dart';

class ProfilePageController extends GetxController {
  final box = GetStorage();

  final userData = {}.obs;
  final role = [].obs;

  var isLoading = false.obs;
  var user = UserModel(
    id: 0,
    name: '',
    email: '',
    identificationNumber: '',
    address: '',
    photo: '',
    roles: [],
    grades: [],
    birthInformation: '',
  ).obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  String getUsername() {
    final username = box.read('username');
    return username;
  }

  Future<void> fetchUser() async {
    isLoading.value = true;
    final token = box.read('token');
    final url = "https://talentaku.site/api/user";
    var headers = {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];
        userData.value = jsonData;
        print(userData);
        role.value = jsonData['roles'];
        isLoading.value = false;
      } else {
        throw Exception("Haloo");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    final token = box.read('token');
    final url = "https://talentaku.site/api/auth/logout";
    var headers = {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        box.erase();
        Get.offAllNamed(Routes.LoginScreen);
      } else {
        throw Exception("Failed to log out");
      }
    } catch (e) {
      throw Exception('Error during logout');
    }
  }
}
