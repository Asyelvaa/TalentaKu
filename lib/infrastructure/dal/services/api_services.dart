// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../../../domain/models/class_model.dart';
import '../../../domain/models/user_model.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  static const String baseUrl = 'https://talentaku.site/api';

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal();
  final box = GetStorage();

  Future<UserModel> getCurrentUser() async {
    try {
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load current user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load current user: $e');
    }
  }

  // Future<void> fetchUser() async {
  //   isLoading.value = true;
  //   final token = box.read('token');
  //   final url = "https://talentaku.site/api/user";
  //   var headers = {
  //     'Accept': 'Application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       userData.value = jsonData['user'];
  //       print(userData);
  //       role.value = jsonData['roles'];
  //       isLoading.value = false;
  //     } else {
  //       throw Exception("Haloo");
  //     }
  //   } catch (e) {
  //     throw Exception('Haii');
  //   }
  // }

  Future<List<GradeModel>> getGrades() async {
    try {
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/grades'),
        headers: headers,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print(token);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['grades'];
        List<GradeModel> grades =
            data.map((json) => GradeModel.fromJson(json)).toList();
        return grades;
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading grades: $e');
      throw Exception('Failed to load grades: $e');
    }
  }

  Future<Map<String, dynamic>> createClass(
      Map<String, dynamic> classData) async {
    try {
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/grades'),
        headers: headers,
        body: jsonEncode(classData),
      );

      print('Request body: ${jsonEncode(classData)}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create class: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating class: $e');
      throw Exception('Failed to create class: $e');
    }
  }

  Future<void> joinClass(String uniqueCode) async {
    try {
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/grades/join'),
        headers: headers,
        body: jsonEncode({'unique_code': uniqueCode}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('Joined class successfully');
      } else {
        throw Exception('Failed to join class:${response.statusCode}');
      }
    } catch (e) {
      print('Error creating class: $e');
      throw Exception('Failed to join class: $e');
    }
  }

  Future<GradeModel> getDetailClass(int id) async {
    try {
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/grades/$id'),
        headers: headers,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print(token);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)['grades'];
        GradeModel grade = GradeModel.fromJson(data);
        return grade;
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading grades: $e');
      throw Exception('Failed to load grades: $e');
    }
  }

  Future<void> classStatus(int gradeId) async {
    try {
      box.read('token');
      final response = await http
          .patch(Uri.parse('$baseUrl/grades/$gradeId/toggle-active'), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          if (data['data']['isactive']) {
            print('Grade has been successfully activated.');
          } else {
            print('Grade has been successfully deactivated.');
          }
        } else {
          print('Failed: ${data['message']}');
        }
      } else {
        print('Failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  ///////
  Future<Map<String, dynamic>> login(String email, password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
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
          return {
            'success': true,
            'data': responseData['data'],
            'token': responseData['token']
          };
        } else {
          final String errorMessage = responseData['message'] ?? 'Login failed';
          return {'success': false, 'message': errorMessage};
        }
      } else {
        return {
          'success': false,
          'message': 'Login failed. Status code: ${response.statusCode}'
        };
      }
    } catch (error) {
      print('Error occurred during login: $error');
      return {'success': false, 'message': 'An error occurred during login.'};
    }
  }

  Future<void> logout() async {
    final token = box.read('token');
    final url = "$baseUrl/auth/logout";
    var headers = {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        box.erase();
      } else {
        throw Exception("Failed to log out");
      }
    } catch (e) {
      throw Exception('Error during logout');
    }
  }

  Future<Map<String, dynamic>> uploadImageToApi(String filePath) async {
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var uri = Uri.parse('$baseUrl/user/update-photo');
    var request = http.MultipartRequest('POST', uri);

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

  Future<Map<String, dynamic>> fetchProgram() async {
    final url = "$baseUrl/programs";
    var headers = {
      'Accept': 'application/json',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return {'success': true, 'programs': jsonData['programs']};
      } else {
        return {'success': false, 'message': 'Failed to fetch programs'};
      }
    } catch (e) {
      print('Error occurred during fetch programs: $e');
      return {
        'success': false,
        'message': 'An error occurred during fetch programs'
      };
    }
  }

  Future<Map<String, dynamic>> fetchContactAndInformation() async {
    final url = "$baseUrl/information";
    var headers = {
      'Accept': 'Application/json',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return {'success': true, 'information': jsonData['information']};
      } else {
        return {'success': false, 'message': 'Failed to fetch information'};
      }
    } catch (e) {
      print('Error occurred during fetch information: $e');
      return {
        'success': false,
        'message': 'An error occurred during fetch information'
      };
    }
  }
}

// class Client {
//   final Dio _dio;

//    Client(this._dio) {
//     _dio.options.baseUrl = 'https://talentaku.site/api';
//     _dio.options.connectTimeout = Duration(seconds: 5); 
//     _dio.options.receiveTimeout = Duration(seconds: 3);
//     _dio.interceptors.add(ApiInterceptors());
//   }

//   Dio get dio => _dio;
// }

// class ApiInterceptors extends Interceptor {
  
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('REQUEST[${options.method}] => PATH: ${options.path}');
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
//     return super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
//     return super.onError(err, handler);
//   }
// }