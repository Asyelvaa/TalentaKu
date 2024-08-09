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
  late String studentSubmitted;
  Rx<Task> task = Task().obs;
  RxBool isLoading = false.obs;
  Rx<SubmissionDetailModel> submission = SubmissionDetailModel().obs;
  RxString selectedScore = ''.obs;
  TextEditingController scoreController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    taskId = arguments['taskId'] as String;
    gradeId = arguments['gradeId'] as String;
    studentSubmitted = arguments['studentSubmitted'] as String;

    print('pass arg in submission: $taskId, $gradeId, $studentSubmitted');
    print(studentSubmitted);
    fetchSubmissionsById();
    fetchTaskDetails();
  }

  // Future<void> fetchSubmissionsById(String taskId) async {
  //   isLoading.value = true;
  //   try {
  //     final response = await ApiServiceTask().getSubmissionWithNullScore(gradeId, taskId);
  //     if (response.containsKey('data')) {
  //       submission.value = SubmissionDetailModel.fromJson(response['data']);
  //       print(' submission submitted : ${submission.value.studentSubmitted}');
  //     } else {
  //       throw Exception('Invalid response format: "data" key not found');
  //     }
  //   } catch (e) {
  //     print('Error fetching submissions detail: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> fetchSubmissionsById() async {
    isLoading.value = true;
    try {
      final response =
          await ApiServiceTask().getSubmissionWithNullScore(gradeId, taskId);

      if (response.containsKey('data')) {
        List<dynamic> submissionsData = response['data'];

        // Filter the submissions to find the one that matches the taskId
        var filteredSubmissions = submissionsData.where((submission) {
          return submission['task_id'].toString() == taskId &&
              submission['student_submitted']['name'] == studentSubmitted;
        }).toList();

        if (filteredSubmissions.isNotEmpty) {
          // Assuming you only need the first matched submission
          submission.value =
              SubmissionDetailModel.fromJson(filteredSubmissions.first);
          print(
              'Submission submitted: ${submission.value.studentSubmitted?.name}');
        } else {
          throw Exception(
              'No submissions found for taskId: $taskId and studentSubmitted: $studentSubmitted');
        }
      } else {
        throw Exception('Invalid response format: "data" key not found');
      }
    } catch (e) {
      print('Error fetching submissions detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTaskDetails() async {
    isLoading.value = true;
    try {
      final taskDetail = await ApiServiceTask().getDetailTask(gradeId, taskId);
      task.value = taskDetail;
    } catch (e) {
      print('Error fetching task details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> scoringSubmission() async {
    var score = scoreController.text;
    var submissionId = submission.value.submissionId.toString();
    isLoading.value = true;
    try {
      final response = await ApiServiceTask()
          .correctionTask(gradeId, taskId, submissionId, score);
      submission.value = SubmissionDetailModel.fromJson(response['message']);
      Get.back();
      dialogSuccess('Berhasil menilai tugas');
    } catch (e) {
      Get.back();
      dialogError('Gagal menilai tugas');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubmissionCompleteById(String completionsId) async {
    isLoading.value = true;
    try {
      submission.value = await ApiServiceTask()
          .getSubmissionById(gradeId, taskId, completionsId);
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
      backgroundColor: AppColor.blue100,
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
