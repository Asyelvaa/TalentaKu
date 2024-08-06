import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/class_model.dart';

class ApiServiceClass {
  static final ApiServiceClass _singleton = ApiServiceClass._internal();
  static const String baseUrl = 'https://talentaku.site/api';

  factory ApiServiceClass() {
    return _singleton;
  }

  ApiServiceClass._internal();
  final box = GetStorage();

  Future<Map<String, dynamic>> createClass(
    String name, 
    String desc, 
    int levelId
    ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', 
    };
    final body = jsonEncode({
      'name': name,
      'desc': desc,
      'level_id': levelId,
    });
    print(token);
    try {
      var response = await http.post(Uri.parse(url),headers: headers,body: body);

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
    final token = box.read('token');
    final url = "$baseUrl/grades/member-join";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      'unique_code': uniqueCode
    });
    try {
      var response = await http.put(Uri.parse(url),headers: headers,body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Joined class successfully');
      } else {
        throw Exception('Failed to join class:${response.statusCode}');
      }
    } catch (e) {
      print('Error creating class: $e');
      throw Exception('Failed to join class: $e');
    }
  }

  Future<Map<String, dynamic>> updateClass(
    String name, 
    String desc, 
    int levelId,
    String gradeId
    ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', 
    };
    final body = jsonEncode({
      'name': name,
      'desc': desc,
      'level_id': levelId,
    });

    try {
      var response = await http.post(Uri.parse(url),headers: headers,body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update class: ${response.statusCode}');
      }
    } catch (e) {
      print('Error update class: $e');
      throw Exception('Failed to update class: $e');
    }
  }

  // DELETE CLASS 
  Future<http.Response?> deleteClass(String gradeId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.delete(Uri.parse(url),headers: headers,);
      print('hapus kelas : ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Class deleted successfully');
      } else {
        throw Exception('Failed to delete class: ${response.statusCode}');
      }
    } catch(e) {
      print('Error deleting class: $e');      
    }
  }

    Future<Map<String, dynamic>?> classStatus(int gradeId) async {
      final token = box.read('token');
      final url = "$baseUrl/grades/$gradeId/toggle-active";
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', 
      };

      try {
        var response = await http.patch(Uri.parse(url),headers: headers,);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['data'] != null) {
            print(data['data']['is_active_status'] == 'active'
                ? 'Grade has been successfully activated.'
                : 'Grade has been successfully deactivated.');
            return data;
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

  Future<GradeModel> getDetailClass(int gradeId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.get(Uri.parse(url),headers: headers,);
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];
        return GradeModel.fromJson(data);
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading grades: $e');
      throw Exception('Failed to load grades: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getGradesTeacher() async {
    final token = box.read('token');
    final url = "$baseUrl/grades/teacher";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(Uri.parse(url),headers: headers,);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading grades: $e');
      throw Exception('Failed to load grades: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getGradesStudent() async {
    final token = box.read('token');
    final url = "$baseUrl/grades/member";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(Uri.parse(url),headers: headers,);
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading grades: $e');
      throw Exception('Failed to load grades: $e');
    }
  }

  // DELETE MEMBER
  Future<void> deleteMember(String gradeId, String memberId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/members/$memberId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.delete(Uri.parse(url),headers: headers,);
      if (response.statusCode == 200) {
        print('Member deleted successfully');
      } else {
        throw Exception('Failed to delete member: ${response.statusCode}');
      }
    } catch(e) {
      print('Error deleting member: $e');      
    }
  }

}