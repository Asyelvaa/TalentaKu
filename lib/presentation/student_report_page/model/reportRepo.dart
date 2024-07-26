// import 'dart:convert';
// import 'package:flutter_talentaku/presentation/student_report_page/model/reportModel.dart';
// import 'package:http/http.dart' as http;


// class ReportRepository {
//   final String baseUrl = 'https://talentaku.site/api/grades/1/student-report/';

//   Future<List<ReportModel>> fetchReports(int id, int gradeId) async {
//     final uri = Uri.parse('$baseUrl?id=$id&grade_id=$gradeId');
    
//     final response = await http.get(
//       uri,
//       headers: {
//         'Content-Type': 'application/json',
//         // Add other headers if needed
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonData = json.decode(response.body);
      
//       if (jsonData['status'] == 'success' && jsonData.containsKey('data')) {
//         final List<dynamic> data = jsonData['data'];
//         return data.map((item) => ReportModel.fromJson(item)).toList();
//       } else {
//         throw Exception('Data field is missing or invalid');
//       }
//     } else {
//       throw Exception('Server error: ${response.statusCode}');
//     }
//   }
// }
