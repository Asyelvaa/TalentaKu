import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class ReportListPageController extends GetxController {
  var isLoading = false.obs;
  var selectedMonth = ''.obs;
  final box = GetStorage();
  var reportData = [].obs;
  var filteredReportData = [].obs;
  final String baseUrl = 'https://talentaku.site/api';
  late final String gradeId;

  final dropdownSemesterController =
      SingleSelectController<String?>('Semester 1');
  final dropdownMonthController = SingleSelectController<String?>(null);

  Future<void> fetchDataReport() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final url = '$baseUrl/grades/$gradeId/student-report/student';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('CHECK FULL DATA FROM API');
        reportData.assignAll(jsonData);
        print(reportData);
        print(reportData.length);
        filterReportData();
      } else {
        print(response.body);
        print("Error fetching report data");
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

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    gradeId = arguments['gradeId'] as String;
    fetchDataReport();
  }

  void onMonthChanged(String? value) {
    selectedMonth.value = value ?? '';
    filterReportData();
  }
}
