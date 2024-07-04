// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
  
  // Future<UserModel> getCurrentUser() async {
  //   try {
  //     final token = box.read('token');
  //     var headers = {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };

  //     final response = await http.get(
  //       Uri.parse('$baseUrl/user'),
  //       headers: headers,
  //     );

  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       return UserModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception('Failed to load current user: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error loading current user: $e');
  //     throw Exception('Failed to load current user: $e');
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
        List<GradeModel> grades = data.map((json) => GradeModel.fromJson(json)).toList();
        return grades;
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading grades: $e');
      throw Exception('Failed to load grades: $e');
    }
  }

  Future<Map<String, dynamic>> createClass(Map<String, dynamic> classData) async {
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