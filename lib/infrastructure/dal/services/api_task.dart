import 'dart:convert';
import 'dart:io';

import 'package:flutter_talentaku/domain/models/submission_detail_model.dart';
import 'package:flutter_talentaku/domain/models/submission_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../domain/models/task_model.dart';
import '../../../domain/models/task_student_model.dart';

class ApiServiceTask {
  static final ApiServiceTask _singleton = ApiServiceTask._internal();
  static const String baseUrl = 'https://talentaku.site/api';

  factory ApiServiceTask() {
    return _singleton;
  }

  ApiServiceTask._internal();
  final box = GetStorage();

  Future<Map<String, dynamic>> createTask(
    Map<String, String> fields, 
    List<File> files, 
    List<String> links, 
    String gradeId
  ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    for (var i = 0; i < links.length; i++) {
      request.fields['links[$i]'] = links[i];
    }

    for (var file in files) {
      request.files.add(
        http.MultipartFile(
          'media[]',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('application', 'octet-stream'),
        ),
      );
    }
    
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create task: ${response.body}');
      }    
    } catch (e) {
      print('Error in cretae task: $e');
      rethrow;
    }
  } 

  // UPDATE TASK
  Future<Map<String, dynamic>> updateTask(String gradeId, String taskId, Map<String, String> fields, List<File> files, List<String> links) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    for (var i = 0; i < links.length; i++) {
      request.fields['links[$i]'] = links[i];
    }

    for (var file in files) {
      request.files.add(
        http.MultipartFile(
          'media[]',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('application', 'octet-stream'),
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update task: ${response.body}');
      }    
    } catch (e) {
      print('Error in update task: $e');
      rethrow;
    }
  }

  // DELETE TASK 
  Future<String> deleteTask(String gradeId, String taskId,) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.delete(Uri.parse(url), headers: headers);

    if(response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      throw Exception('Failed to delete task: ${response.body}');
    }
  }

  // CORRECTION TASK / SCORING TASK
  Future<Map<String, dynamic>> correctionTask(String gradeId, String taskId, String submissionId, String score) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId/submissions/$submissionId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final body = jsonEncode({'score': score});
    print(body);
    print(url);
    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to score submission');
    }
  }

  // SUBMIT TASK
  Future<SubmissionModel> submitTask(String gradeId, String taskId, List<File> files) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId/submission";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    for (var file in files) {
      request.files.add(
        http.MultipartFile(
          'media[]',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('application', 'octet-stream'),
        ),
      );
    }
    print(files.toList());
    print(url);
    print(headers);


    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return SubmissionModel.fromJson(responseData);
      } else {
        throw Exception('Failed to submit task: ${response.body}');
      }    
    } catch (e) {
      print('Error in submit task: $e');
      rethrow;
    }
  }

  // SHOW ALL TASK BY GRADE
  Future<List<Task>> getAllTaskTeacher(String gradeId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data')) {
        List tasksData = jsonResponse['data'];
        return tasksData.map((task) => Task.fromJson(task)).toList();
      } else {
        throw Exception('Invalid response format: "data" key not found');
      }
    } else {
      throw Exception('Failed to load class:${response.statusCode}');
    }
  }

  Future<List<TaskStudentModel>> getAllTaskStudent(String gradeId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse(url),headers: headers);

    if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data')) {
        List tasksData = jsonResponse['data'];
        return tasksData.map((task) => TaskStudentModel.fromJson(task)).toList();
      } else {
        throw Exception('Invalid response format: "data" key not found');
      }
    } else {
      throw Exception('Failed to load class:${response.statusCode}');
    }
  } 

  // SHOW TASK BY ID
  Future<Task> getDetailTask(String gradeId, String taskId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Task.fromJson(json['data']);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // SHOW SUBMISSION BY ID
  Future<SubmissionDetailModel> getSubmissionById(String gradeId, String taskId, String completionsId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId/completions/$completionsId";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      
      return SubmissionDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load submissions detail');
    }
  }

  // SHOW SUBMISSION NULL SCORE
   Future<Map<String, dynamic>> getSubmissionWithNullScore(String gradeId, String taskId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId/completions";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load submissions with null score: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getSubmissionWithScore(String gradeId, String taskId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId/completions-with-scores";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load submissions with score: ${response.reasonPhrase}');
    }
  }

}