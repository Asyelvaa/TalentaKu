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

  Future<void> fetchDataReport() async {
    isLoading.value = true;
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
          Uri.parse('$baseUrl/grades/1/student-report/student'),
          headers: headers);

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final jsonData = json.decode(response.body);
        reportData.assignAll(jsonData['data']);
      } else {
        print("cuk");
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
