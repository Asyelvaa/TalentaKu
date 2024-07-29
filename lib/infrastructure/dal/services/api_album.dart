import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../../../domain/models/album_model.dart';

class ApiServiceAlbum {
  static final ApiServiceAlbum _singleton = ApiServiceAlbum._internal();
  static const String baseUrl = 'https://talentaku.site/api';

  factory ApiServiceAlbum() {
    return _singleton;
  }

  ApiServiceAlbum._internal();
  final box = GetStorage();

  Future<Map<String, dynamic>> createAlbum({
    required String gradeId,
    required String desc,
    required List<File> media,
  }) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/albums";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['desc'] = desc;
    
    for (var file in media ) {
      final mimeType = lookupMimeType(file.path);
      if (mimeType != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'media[]',
          file.path,
          contentType: MediaType.parse(mimeType),
        ));        
      }
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create album: ${response.body}');
      }    
    } catch (e) {
      print('Error in postAlbum: $e');
      rethrow;
    }
  }

  Future<List<Album>> getAllAlbum(int gradeId) async {
    final token = box.read('token');
    final url = "$baseUrl/grades/$gradeId/albums";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          List<dynamic> albumsJson = jsonResponse['data'];
          return albumsJson.map((albumJson) => Album.fromJson(albumJson)).toList();
        } else {
          throw Exception('Failed to load albums');
        }
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  // GET DETAIL ALBUM

  // DELETE ALBUM

}