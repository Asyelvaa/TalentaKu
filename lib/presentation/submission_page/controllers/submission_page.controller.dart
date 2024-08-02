import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/submission_detail_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../infrastructure/dal/services/api_task.dart';
import '../../../infrastructure/theme/theme.dart';

class SubmissionPageController extends GetxController {

  late String gradeId;
  late String taskId;
  late Task task;
  RxBool isLoading = false.obs;
  Rx<SubmissionDetailModel> submission = SubmissionDetailModel().obs;
  TextEditingController scoreController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    task = arguments['task'] as Task;
    gradeId = arguments['gradeId'] as String;
    fetchSubmissionsById(task.id.toString());
  }
  
  Future<void> fetchSubmissionsById(String taskId) async {
    isLoading.value = true;
    try {
      final response = await ApiServiceTask().getSubmissionWithNullScore(gradeId, taskId);
      if (response.containsKey('data')) {
        submission.value = SubmissionDetailModel.fromJson(response['data']);
      } else {
        throw Exception('Invalid response format: "data" key not found');
      }
    } catch (e) {
      print('Error fetching submissions detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> scoringSubmission(String submissionId, String score) async {
    isLoading.value = true;
    try {
      final response = await ApiServiceTask().correctionTask(gradeId, task.id.toString(), submissionId, score);
      submission.value = SubmissionDetailModel.fromJson(response['message']);
      dialogSuccess('Submission has been scored');
    } catch (e) {
      dialogError('Failed to score submission');
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> fetchSubmissionCompleteById(String completionsId) async {
    isLoading.value = true;
    try {
      submission.value = await ApiServiceTask().getSubmissionById(gradeId, taskId, completionsId);
      print(submission.value.studentSubmitted);
      print(submission.value.submissionId);
      print(submission.value.submissionMedia);
    } catch (e) {
      print('Error fetching submission details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void dialogSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:AppColor.blue100,
      colorText: AppColor.black,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  void dialogError(String message) {
    Get.snackbar(
      'Gagal',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

}
