import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportListPageController extends GetxController {
  //TODO: Implement ReportListPageController
  var isLoading = false.obs;
  late final arguments;
  final box = GetStorage();
  var reportData = [].obs;
  final String baseUrl = 'https://talentaku.site/api';
  late final String gradeId;

  Future<void> fetchDataReport() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final url = '$baseUrl/grades/$gradeId/student-report/student';
    try {
      final response = await http.get(
          Uri.parse(url),
          headers: headers);
      print(headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final jsonData = json.decode(response.body);
        reportData.assignAll(jsonData['data']);
      } else {
        print(response.body);
        print("error fetch report");
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    fetchDataReport();
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    gradeId = arguments['gradeId'] as String;
    print(gradeId);
    fetchDataReport();
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
