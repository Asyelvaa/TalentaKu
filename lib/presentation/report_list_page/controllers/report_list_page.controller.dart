import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class ReportListPageController extends GetxController {
  var isLoading = false.obs;
  var selectedSemester = '1'.obs;
  final box = GetStorage();
  var reportData = [].obs;
  var filteredReportData = [].obs;
  final String baseUrl = 'https://talentaku.site/api';
  late final String gradeId;

  final dropdownController =
      SingleSelectController<String?>('Semester 1');

  Future<void> fetchDataReport() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
          Uri.parse('$baseUrl/grades/$gradeId/student-report/student'),
          headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        reportData.assignAll(jsonData['data']);
        filterReportData(); 
      } else {
        print(response.body);
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterReportData() {
    filteredReportData.assignAll(
      reportData
          .where((report) => report['semester_id'] == selectedSemester.value)
          .toList(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    gradeId = arguments['gradeId'] as String;
    fetchDataReport();
  }
}
