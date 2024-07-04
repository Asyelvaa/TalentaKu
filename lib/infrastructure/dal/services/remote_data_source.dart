// import 'package:dio/dio.dart';
// import 'package:flutter_talentaku/domain/models/class_model.dart';
// import 'package:flutter_talentaku/domain/models/user_model.dart';
// import 'package:flutter_talentaku/infrastructure/dal/services/api_services.dart';

// class RemoteDataSource {
//   final Client client;

//   RemoteDataSource(this.client);
  
//   Future<void> login(String email, String password) async {
//     try {
//       final response = await client.dio.post(
//         '/auth/login',
//         data: {
//           'email': email,
//           'password': password,
//         },
//       );
//        if (response.statusCode == 200) {
//         final responseData = response.data;
//         final success = responseData['success'];

//         if (success) {
//           final String token = responseData['token'];
//           client.dio.options.headers['Authorization'] = 'Bearer $token';
//         } else {
//           final String errorMessage = responseData['message'] ?? 'Login gagal';
//           throw Exception(errorMessage);
//         }
//       } else {
//         throw Exception('Failed to login. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error occurred during login: $error');
//       throw Exception('An error occurred during login');
//     }
//   }

//   Future<void> uploadImageProfile(String filePath) async {
//     try {
//       final token = client.dio.options.headers['Authorization'];
//       final formData = FormData.fromMap({
//         'file': await MultipartFile.fromFile(filePath, filename: 'upload.jpg'),
//       });

//       final response = await client.dio.post(
//         '/user/update-photo',
//         data: formData,
//         options: Options(headers: {'Authorization': token}),
//       );

//       if (response.statusCode == 200) {
//         print("Image uploaded successfully");
//       } else {
//         print("Image upload failed");
//       }
//     } catch (e) {
//       print("Error during image upload: $e");
//       throw Exception('Error during image upload');
//     }
//   }

//   Future<Response> logout() async {
//   try {
//     final response = await client.dio.post('/auth/logout');
//     return response; 
//   } catch (error) {
//     print('Error occurred during logout: $error');
//     throw Exception('An error occurred during logout');
//   }
//   }

//   Future<UserModel> fetchUser() async {
//     try {
//       final response = await client.dio.get('/user');
//       return UserModel.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to load user');
//     }
//   }

//   Future<List<GradeModel>> fetchGrades() async {
//     try {
//       final response = await client.dio.get('/grades');
//       return (response.data as List).map((grade) => GradeModel.fromJson(grade)).toList();
//     } catch (e) {
//       throw Exception('Failed to load grades');
//     }
//   }

//   Future<Map<String, dynamic>> createClass(Map<String, dynamic> classData) async {
//     try {
//       final response = await client.dio.post('/grades', data: classData);
//       return response.data;
//     } catch (e) {
//       throw Exception('Failed to create class');
//     }
//   }

//   Future<Map<String, dynamic>> joinClass(Map<String, dynamic> classData) async {
//     try {
//       final response = await client.dio.post('/grades/join', data: classData);
//       return response.data;
//     } catch (e) {
//       throw Exception('Failed to join class');
//     }
//   }
// }
