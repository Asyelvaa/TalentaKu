import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../domain/models/task_model.dart';

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

  // DELETE TASK 

  // CORRECTION TASK / SCORING TASK

  // SUBMIT TASK

  // GET ALL TASK
  Future<List<Task>> getAllTask(String gradeId) async {
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

  // GET DETAIL TASK
  Future<Task> getDetailTask(String gradeId, String taskId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/tasks/$taskId";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // GET SUBMISSION DETAIL 

  // GET SUBMISSION NULL SCORE

  // GET SUBMISSION WITH SCORE
}