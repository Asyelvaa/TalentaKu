import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class ProfilePageController extends GetxController {
  final box = GetStorage();

  final userData = {}.obs;
  final role = [].obs;

  var isLoading = false.obs;
  var user = UserModel(
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
    user.value = UserModel(
      id: box.read('id') ?? 0,
      name: box.read('name') ?? '',
      email: box.read('email') ?? '',
      emailVerifiedAt: box.read('emailVerifiedAt') ?? '',
      nomorInduk: box.read('nis') ?? '',
      address: box.read('address') ?? '',
      birthDate: box.read('birthDate') ?? '',
      photo: box.read('photo') ?? '',
      createdAt: box.read('createdAt') ?? '',
      updatedAt: box.read('updatedAt') ?? '',
      roles: (box.read('roles') ?? []).cast<String>(),
      grades: box.read('grades') ?? '',
    );
  }

  void logout() {
    box.erase();
  }
}
