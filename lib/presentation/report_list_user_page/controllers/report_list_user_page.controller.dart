import 'dart:convert';
import 'dart:ffi';

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
  var reportData = [].obs;
  final String baseUrl = 'https://talentaku.site/api';

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
        reportData.assignAll(jsonData['data']);
      } else {
        print(response.statusCode);
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
