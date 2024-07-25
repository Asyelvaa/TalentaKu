import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DailyReportController extends GetxController {
  final reportData = {}.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReportData();
  }

  Future<void> fetchReportData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(
          Uri.parse('https://talentaku.site/api/grades/3/student-report/3'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        reportData.value = data['data'];
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      errorMessage.value = 'Network error: $e';
      print('Network error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
