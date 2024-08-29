import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class ApiServiceInformation {
  static const String baseUrl =  'https://talentaku.site/api';
  final box = GetStorage();

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