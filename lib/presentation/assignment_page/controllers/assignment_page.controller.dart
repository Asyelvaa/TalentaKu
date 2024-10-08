import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_task.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/submission_detail_model.dart';
import '../../../domain/models/submission_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/models/task_student_model.dart';
import '../../class_detail_page/controllers/class_detail.controller.dart';

class AssignmentPageController extends GetxController  with GetTickerProviderStateMixin {

  var isLoading = true.obs;

  RxList<Task> teacherTaskList = <Task>[].obs;
  RxList<TaskStudentModel> studentTaskList = <TaskStudentModel>[].obs;
  Rxn<Task> taskDetail = Rxn<Task>();
  final controller = Get.put(ClassDetailController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final selectedDate = Rxn<DateTime>();
  var links = <String>[].obs;
  var picker = ImagePicker();
  var selectedFiles = <File>[].obs;
  var isLinkInputVisible = false.obs;

  RxList<SubmissionDetailModel> submissionsWithNullScore = <SubmissionDetailModel>[].obs;
  RxList<SubmissionDetailModel> submissionsWithScore = <SubmissionDetailModel>[].obs;
  var submissionFiles = <File>[].obs;
  var score = ''.obs;

  late TabController tabController;
  late final String gradeId;
  late final String taskId;
  late final List<String> userRole = GetStorage().read('dataUser')['role'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    final arguments = Get.arguments as Map<String, dynamic>;
    taskId = arguments['taskId'] as String;
    gradeId = arguments['gradeId'] as String;
    fetchTaskDetails();
    fetchSubmissionsWithNullScore();
    fetchSubmissionsWithScore();
    
  }


  // CREATE TASK
  Future<void> pickMedia(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source) ?? await picker.pickVideo(source: source);
    if (pickedFile != null) {
      selectedFiles.add(File(pickedFile.path));
    }
  }

  void removeSelectedFile(File file) {
     selectedFiles.removeWhere((element) => element.path == file.path);
  }

  void addLink() {isLinkInputVisible.value = true;}

  void submitLink() {
    if (linkController.text.isNotEmpty) {
      links.add(linkController.text);
      linkController.clear();
      isLinkInputVisible.value = false;
    }
  }
  
  void pickDate( BuildContext context) {
    showDatePicker(
      context:context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        selectedDate.value = value;
      }
    });
  }

  Future<void> createTask() async {
    final title = titleController.text;
    final desc = descController.text;
    final endDate = selectedDate.value != null
        ? '${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}'
        : '';

    if (title.isEmpty || desc.isEmpty || endDate.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    Map<String, String> fields = {
      'title': title,
      'desc': desc,
      'end_date': endDate,
    };

    try {
      await ApiServiceTask().createTask(fields, selectedFiles, links, gradeId); 
      print('success');
      
      controller.fetchAllTask();
      controller.fetchAlbums();
      controller.fetchStream();
      
      titleController.clear();
      descController.clear();
      selectedDate.value = null;
      Get.back();
      update();     
      dialogSuccess('Berhasil membuat tugas');
    } catch(e) {
      print('failed');
      dialogError('Gagal membuat tugas: $e');
    }
  }

  // UPDATE TASK

  // DELETE TASK 
  Future<void> deleteTask(String taskId) async {
    
    print('Deleting task with id $taskId in $gradeId');
    try {
      await ApiServiceTask().deleteTask(gradeId, taskId);
      controller.fetchAllTask();
      Get.back();
      print('Task with id $taskId deleted');
      dialogSuccess('Task successfuly deleted');
    } catch (e) {
      print('Error deleting task: $e');
      dialogError('Error deleting task: $e');
    }
  }

  Rx<SubmissionModel> submissionData = SubmissionModel().obs;
  // SUBMIT TASK
  Future<void> submitTask(String taskId) async {
    try {
      final response = await ApiServiceTask().submitTask(
        gradeId,
        taskId,
        submissionFiles
      );
      print('Task submitted successfully with ID: ${taskId}');
      submissionData.value = response;
      controller.fetchAllTask();
      Get.back(); 
      dialogSuccess('Tugas Berhasil Dikumpulkan');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit task');    }
  }

  void removeSubmissionMedia(File file) {
     submissionFiles.removeWhere((element) => element.path == file.path);
  }
  // var mediaPaths = <String>[].obs;
  Future<void> pickSubmissionMedia() async {
    final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        submissionFiles.add(File(pickedFile.path));
      }   
    print("Media Paths: $submissionFiles");
  }

  // SHOW TASK BY ID
  
  Future<void> fetchTaskDetails() async {
    isLoading.value = true;
    try {
      final taskDetails = await ApiServiceTask().getDetailTask(gradeId, taskId);
      taskDetail.value = taskDetails;
      print(taskDetail.value!.title);
    } catch (e) {
      print("Error fetching task details: $e"); 
    } finally {
      isLoading.value = false;
    }
  }
  
  // SHOW SUBMISSION NULL SCORE 
 Future<void> fetchSubmissionsWithNullScore() async {
  isLoading.value = true;
  try {
    final response = await ApiServiceTask().getSubmissionWithNullScore(gradeId, taskId);
    if (response.containsKey('data')) {
      var data = response['data'];
      submissionsWithNullScore.value = (data as List)
        .map((submission) => SubmissionDetailModel.fromJson(submission))
        .toList();
      print('submission: ${submissionsWithNullScore}');
    } else {
      throw Exception('Invalid response format: "data" key not found');
    }
    print('Submissions with null score: $submissionsWithNullScore');
  } catch (e) {
    print('Error fetching submissions with null score: $e');
  } finally {
    isLoading.value = false;
  }
 }


  Future<void> fetchSubmissionsWithScore() async {
    isLoading.value = true;
    try {
      final response = await ApiServiceTask().getSubmissionWithScore(gradeId, taskId);
      if (response.containsKey('data')) {
        submissionsWithScore.assignAll((response['data'] as List)
        .map((submission) => SubmissionDetailModel.fromJson(submission)).toList());
      } else {
        throw Exception('Invalid response format: "data" key not found');
      }
      print('Submissions with score: $submissionsWithScore');
    } catch (e) {
      print('Error fetching submissions with score: $e');
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

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    linkController.dispose();
    super.onClose();
  }
}
