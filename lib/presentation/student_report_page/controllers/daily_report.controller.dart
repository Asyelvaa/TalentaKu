import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/reportModel.dart';

class DailyReportController extends GetxController {
  var reportData = [].obs;
  var singleReportData = {}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  late final arguments;

  

  ReportModel? getReportById(int id) {
    return null;

    // try {
    //   return reportData.firstWhere((report) => report.id == id);
    // } catch (e) {
    //   print("Error finding report by ID: $e");
    //   return null;
    // }
  }

  @override
  void onInit() {
    arguments = Get.arguments;
    singleReportData.value = arguments[0];
    super.onInit();
  }
}
