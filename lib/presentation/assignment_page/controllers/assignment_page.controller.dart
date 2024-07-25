import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/task_model.dart';
import '../../../infrastructure/dal/services/api_services.dart';

class AssignmentPageController extends GetxController  with GetSingleTickerProviderStateMixin {

  final selectedDate = Rxn<DateTime>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final links = <String>[].obs;
  final picker = ImagePicker();
  var selectedFiles = <File>[].obs;
  var isLinkInputVisible = false.obs;

  RxList<Task> taskList = <Task>[].obs;
 
  late TabController tabController;
  late final String gradeId;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
    gradeId = Get.arguments as String;
    print(gradeId);
    tabController = TabController(length: 2, vsync: this);
  }

  void fetchCurrentUser() {
    final box = GetStorage();
    Map<String, dynamic>? dataUser = box.read('dataUser');
    if (dataUser != null) {
      print(dataUser);
    }
  }

  Future<void> pickMedia(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source) ?? await picker.pickVideo(source: source);
    if (pickedFile != null) {
      selectedFiles.add(File(pickedFile.path));
    }
  }

  void addLink() {
    isLinkInputVisible.value = true;
  }

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
 
  // void selectImage() async {
  //   final List<XFile>? selectedImage = await _picker.pickMultiImage();
  //   if (selectedImage != null) {
  //     imageFileList.addAll(selectedImage);
  //   } 
  // }

  Future<void> createTask() async {
    fetchCurrentUser();
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
      await ApiService().createTask(fields, selectedFiles, links, gradeId); 
      print('success');
      Get.snackbar('Success', 'Task created successfully');
    } catch(e) {
      print('failed');
      Get.snackbar('Failed', 'Failed to create task: $e');
    }
  }

  Future<void> fetchTasks() async {
    try {
      taskList.assignAll(await ApiService().fetchTask(gradeId));
    } catch(e) {
      print('failed');
      Get.snackbar('Failed', 'Failed to fetch tasks: $e');
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    linkController.dispose();
    super.onClose();
  }
}
