import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../../../domain/models/user_model.dart';

class ApiServiceUser {
  static final ApiServiceUser _singleton = ApiServiceUser._internal();
  static const String baseUrl = 'https://talentaku.site/api';
  // static const String baseUrl = 'https://talentaku-api.rplrus.com/api';
  

  factory ApiServiceUser() {
    return _singleton;
  }

  ApiServiceUser._internal();
  final box = GetStorage();

  Future<Map<String, dynamic>> login(String username, password) async {
    final url = "$baseUrl/auth/login";
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode({
      'username': username,
      'password': password,
    });
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
  
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to login with status code ${response.statusCode}');
    }
  }

 Future<Map<String, dynamic>> updateUserPassword(
      String currentPassword, String newPassword, String newPasswordConfirmation) async {
    final token = box.read('token');
    final url = "$baseUrl/user/update-password";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Added missing Content-Type header
    };
    final body = jsonEncode({
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Password updated successfully'};
      } else {
        print('Failed to update password: ${response.statusCode} ${response.body}');
        return {'success': false, 'message': 'Failed to update password: ${response.body}'};
      }
    } catch (e) {
      print('Error occurred during password update: $e');
      return {'success': false, 'message': 'An error occurred during password update: $e'};
    }
  }

  Future<void> logout() async {
    final token = box.read('token');
    final url = "$baseUrl/auth/logout";
    final headers = {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    };
    print(headers);
    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        box.erase();
        print('loging out user');
      } else {
        throw Exception("Failed to log out");
      }
    } catch (e) {
      throw Exception('Error during logout: $e');
    }
  }

  Future<Map<String, dynamic>> postUserProfilePhoto(String filePath) async {
    final token = box.read('token');
    final url = "$baseUrl/user/update-photo";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var multipart = await http.MultipartFile.fromPath('file', filePath,
        filename: path.basename(filePath));

    request.headers.addAll(headers);
    request.files.add(multipart);
    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Image uploaded successfully'};
      } else {
        return {'success': false, 'message': responseBody.body};
      }
    } catch (e) {
      print('Error occurred during image upload: $e');
      return {
        'success': false,
        'message': 'An error occurred during image upload'
      };
    }
  }

   Future<http.Response> updatePassword(Map<String, dynamic> body) async {
    final token = GetStorage().read('token');
    final url = "$baseUrl/user/update-password";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', 
    };

    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );
  }

  Future<UserModel> getUserData() async {
    final token = box.read('token');
    final url = "$baseUrl/user";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);
      print(response.statusCode); 
      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('Failed to load current user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load current user: $e');
    }
  }
}
