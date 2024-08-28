import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/screens.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/submission_detail_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../infrastructure/dal/services/api_task.dart';
import '../../../infrastructure/theme/theme.dart';

class SubmissionPageController extends GetxController {

  var gradeId = ''.obs;
  var taskId = ''.obs;
  var studentIdSubmitted = ''.obs;
  var completionsId = ''.obs;
  Rx<Task> task = Task().obs;
  RxBool isLoading = false.obs;
  Rx<SubmissionDetailModel> submission = SubmissionDetailModel().obs;
  RxString selectedScore = 'A'.obs; 
  TextEditingController scoreController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    taskId.value = arguments['taskId'].toString();
    gradeId.value = arguments['gradeId'].toString();
    studentIdSubmitted.value = arguments['studentIdSubmitted'].toString();
    completionsId.value = arguments['completionsId'].toString();
    print('pass arg in submission: $taskId, $gradeId, $studentIdSubmitted');
    print(studentIdSubmitted);
    fetchSubmissionsById();
    fetchTaskDetails();
    fetchSubmissionCompleteById();

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
    final response = await ApiServiceTask().getSubmissionWithNullScore(gradeId.value, taskId.value);
    
    if (response.containsKey('data')) {
      List<dynamic> submissionsData = response['data'];

      var filteredSubmissions = submissionsData.where((submission) {
          return submission['task_id'].toString() == taskId.value &&
                 submission['student_submitted']['id'].toString() == studentIdSubmitted.value;
        }).toList();

        print('filteredSubmissions $filteredSubmissions');

      if (filteredSubmissions.isNotEmpty) {
          submission.value = SubmissionDetailModel.fromJson(filteredSubmissions.first);
          print('Submission submitted: ${submission.value.studentSubmitted?.name}');
        } else {
          throw Exception('No submissions found for taskId: $taskId and studentSubmitted: $studentIdSubmitted');
        }
    } else {
      throw Exception('Invalid response format: "data" key not found');
    }
  } catch (e) {
    print('Error fetching submissions list: $e');
  } finally {
    isLoading.value = false;
  }
}
  Future<void> fetchTaskDetails() async {
    isLoading.value = true;
    try {
      final taskDetail = await ApiServiceTask().getDetailTask(gradeId.value, taskId.value);
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
      final response = await ApiServiceTask().correctionTask(gradeId.value, taskId.value, submissionId, selectedScore.value,);
      submission.value = SubmissionDetailModel.fromJson(response['data']);
      Get.back();
      // Get.to(SubmissionCompletePageScreem());
      dialogSuccess('Berhasil menilai tugas');
    } catch (e) {
      Get.back();
      dialogError('Gagal menilai tugas');
      print('gagal nilai tugas $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Rx<SubmissionDetailModel> submissionComplete = SubmissionDetailModel().obs;
  var submissionComplete = {}.obs;
  Future<void> fetchSubmissionCompleteById() async {
    isLoading.value = true;
    try {
      List<dynamic> data = await ApiServiceTask().getSubmissionById(
        gradeId.value, 
        taskId.value, 
        completionsId.value,
      );
      // submissionComplete.value = data[0];
      if (data.isNotEmpty) {
      submissionComplete.value = data[0];  // Mengambil elemen pertama dari array
    } else {
      print('No submissions found.');
    }
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
