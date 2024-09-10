import 'dart:convert';
import 'dart:ffi';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportListUserPageController extends GetxController {
  var isLoading = false.obs;
  late final int userId;
  late final int gradeId;
  late final arguments;
  final box = GetStorage();
    var selectedMonth = ''.obs;
  var reportData = [].obs;
    var filteredReportData = [].obs;
  final String baseUrl = 'https://talentaku.site/api';
    final dropdownMonthController = SingleSelectController<String?>(null);

  Future<void> fetchUserReport() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
          Uri.parse('$baseUrl/grades/$gradeId/student-report/student/$userId'),
          headers: headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final jsonData = json.decode(response.body);
        reportData.assignAll(jsonData);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterReportData() {
    print('Test Current Filter Report Data');
    filteredReportData.assignAll(
      reportData.where((report) {
        final isMonthMatch = selectedMonth.value.isEmpty ||
            report['month'].contains(selectedMonth.value.split(' ')[0]);
        return isMonthMatch;
      }).toList(),
    );

    final List<dynamic> allReports = filteredReportData.expand((monthData) => monthData['reports']).toList();

    print(filteredReportData.length);
    print(allReports.length);

    print('Test After Filter Report Data');
  }
  void onMonthChanged(String? value) {
    selectedMonth.value = value ?? '';
    filterReportData();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    gradeId = arguments[1];
    userId = arguments[0];
    fetchUserReport();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
