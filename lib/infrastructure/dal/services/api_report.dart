import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../presentation/student_report_page/model/reportModel.dart';


class ApiServiceReport {
  static final ApiServiceReport _singleton = ApiServiceReport._internal();
  static const String baseUrl = 'https://talentaku.site/api';

  factory ApiServiceReport() {
    return _singleton;
  }

  ApiServiceReport._internal();
  final box = GetStorage();


  // CREATE REPORT

  // UPDATE REPORT

  // DELETE REPORT

  // GET DETAIL REPORT

  // GET ALL REPORT TEACHER

  // GET REPORT BY SEMESTER TEACHER

  // GET ALL REPORT STUDENT
  Future<List<ReportModel>> getAllReportStudent(int id, int gradeId) async {
    final uri = Uri.parse('$baseUrl/grades/1/student-report/?id=$id&grade_id=$gradeId');
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(
      uri,
      headers:headers
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      
      if (jsonData['status'] == 'success' && jsonData.containsKey('data')) {
        final List<dynamic> data = jsonData['data'];
        return data.map((item) => ReportModel.fromJson(item)).toList();
      } else {
        throw Exception('Data field is missing or invalid');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  // GET REPORT BY SEMESTER STUDENT
}