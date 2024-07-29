import 'package:flutter_talentaku/infrastructure/dal/services/api_class.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_report.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/reportModel.dart';
import '../model/reportRepo.dart';

class DailyReportController extends GetxController {
  final reportData = [].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final box = GetStorage();

  final String baseUrl = 'https://talentaku.site/api';
  @override
  void onInit() {
    super.onInit();
    fetchDataReport();
  }

  Future<void> fetchDataReport() async {
    isLoading.value = true;
    final uri = Uri.parse('$baseUrl/grades/1/student-report/?id=1&grade_id=3');
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      reportData.value = jsonData['data'];
      isLoading.value = false;
    } else {
      isLoading.value = false;
      throw Exception('Server error: ${response.statusCode}');
    }
    isLoading.value = false;
  }

  Future<void> fetchReportData() async {
    // final ReportRepository _repository = ReportRepository();
    var isLoading = false.obs;
    var errorMessage = ''.obs;
    var reportData = <ReportModel>[].obs;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final reports = await ApiServiceReport().getAllReportStudent(1, 1);
      reportData.value = reports;
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
