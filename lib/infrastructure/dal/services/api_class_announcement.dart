import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../domain/models/class_announcement_model.dart';

class ApiServiceAnnouncements {
  static const String baseUrl = 'https://talentaku.site/api';
  final box = GetStorage();

// CREATE announcements
  Future<ClassAnnouncementModel> createAnnouncement(
    String announcements,
    List<File> files, 
    String gradeId
  ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/announcements";
    final headers = {
      'Accept': 'application/json', 
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    request.fields['announcements'] = announcements;

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
      print(response.body);
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['data'];
        return ClassAnnouncementModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to create announcement: ${response.body}');
      }
    } catch (e) {
      print('Error in create announcement: $e');
      rethrow;
    }
  }

  // DELETE announcements
   Future<void> deleteAnnouncement(String gradeId, String announcementsId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/announcements/$announcementsId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(url);
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      print(response.statusCode);
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

// CREATE announcements REPLY
  Future<void> createAnnouncementReply(
    String gradeId,
    String announcementsId,
    List<String> replies
  ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/announcements/$announcementsId/replies";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final body = jsonEncode({
      'replies': replies,
    });

    try {
      final response = await http.post(Uri.parse(url),headers: headers,body: body,);
      if (response.statusCode == 201) {
        print('Reply created successfully');
      } else {
        throw Exception('Failed to create reply: ${response.body}');
      }
    } catch (e) {
      print('Error in create reply: $e');
      rethrow;
    }
  }

// DELETE announcements REPLY
  Future<void> deleteAnnouncementReply(
    String gradeId,
    String announcementsId,
    String replyId
  ) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/announcements/$announcementsId/replies/$replyId";
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.delete(Uri.parse(url), headers: headers,);
      if (response.statusCode == 200) {
        print('Reply deleted successfully');
      } else {
        throw Exception('Failed to delete reply: ${response.body}');
      }
    } catch (e) {
      print('Error in delete reply: $e');
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
// UPDATE COMMENT REPLY


