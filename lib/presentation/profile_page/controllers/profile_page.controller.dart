import 'dart:convert';

import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/class_model.dart';
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
    birthDate: '',
    photo: '',
    roles: [],
    grades: [],
  ).obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();

    loadUserData();
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
        final jsonData = json.decode(response.body);
        userData.value = jsonData['user'];
        print(userData);
        role.value = jsonData['roles'];
        isLoading.value = false;
      } else {
        throw Exception("Haloo");
      }
    } catch (e) {
      throw Exception('Haii');
    }
  }

  void loadUserData() {
    List<String> storedGrades = (box.read('grades') ?? []).cast<String>();
    List<GradeModel> grades = storedGrades
        .map((gradeJson) => GradeModel.fromJson(jsonDecode(gradeJson)))
        .toList();
    user.value = UserModel(
      id: box.read('id') ?? 0,
      name: box.read('name') ?? '',
      email: box.read('email') ?? '',
      identificationNumber: box.read('nis') ?? '',
      address: box.read('address') ?? '',
      birthDate: box.read('birthDate') ?? '',
      photo: box.read('photo') ?? '',
      roles: (box.read('roles') ?? []).cast<String>(),
      grades: grades,
    );
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

