import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../domain/models/class_announcement_model.dart';

class ApiServiceAnnouncements {
static const String baseUrl = 'https://talentaku.site/api';
final box = GetStorage();

// CREATE COMMENT
  Future<ClassAnnouncementModel> createAnnouncement(
    String comments,
    List<File> files, 
    String gradeId
  ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/comments";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    request.fields['comments'] = comments;

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
        var jsonResponse = jsonDecode(response.body)['comment'];
        return ClassAnnouncementModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to create announcement: ${response.body}');
      }    
    } catch (e) {
      print('Error in cretae announcement: $e');
      rethrow;
    }
  } 

  // DELETE COMMENT
   Future<void> deleteAnnouncement(String gradeId, String commentId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/comments/$commentId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.delete(Uri.parse(url),headers: headers,);
      if (response.statusCode == 200) {
        print('Announcement deleted');
      } else {
        throw Exception('Failed to delete announcement: ${response.body}');
      }
    } catch (e) {
      print('Error in delete announcement: $e');
      rethrow;
    }
  }

  // GET DETAIL COMMENTS AND REPLIES
  // Future<Map<String,dynamic>> getAllClassStream(String gradeId) async {
  //   final token = box.read('token');
  //   final url = "$baseUrl/grades/$gradeId/stream";
  //   final headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(Uri.parse(url), headers: headers);
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load class stream');
  //   }
  // }
  
}

// UPDATE COMMENT 

// CREATE COMMENT REPLY

// UPDATE COMMENT REPLY

// DELETE COMMENT REPLY

